import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import Argo
import XCGLogger

class FacebookService: NSObject {

    private var readPermissions = ["user_birthday", "email", "user_likes", "user_friends"]
    private var publishPermissions = ["publish_actions"]
    private var appRequestDialog: FBSDKGameRequestDialog!

    class var service: FacebookService {

        struct Singleton {
            static var onceToken: dispatch_once_t = 0
            static var instance: FacebookService!
        }

        dispatch_once(&Singleton.onceToken) {
            Singleton.instance = FacebookService()
        }

        return Singleton.instance
    }

    private lazy var loginManager: FBSDKLoginManager = {
        var manager = FBSDKLoginManager()
        manager.logOut()
        return manager
    }()

    func loginFacebook(successHandler: FBSDKLoginManagerLoginResult -> (), failureHandler: NSError -> ()) {
        loginManager.logInWithReadPermissions(readPermissions) {
            (result, error) -> Void in
            if let e = error {
                failureHandler(e)
            }

            if let r = result {

                if r.isCancelled {
                    failureHandler(CustomErrors.SocialFacebookAuthCancelledError)
                }

                successHandler(r)

            } else {
                failureHandler(CustomErrors.SocialFacebookResultNilError)
            }
        }
    }

    func getPublishPermissionsIfNecessary(successHandler: (FBSDKLoginManagerLoginResult?, String!) -> (), failureHandler: NSError? -> ()) {
        if let token = FBSDKAccessToken.currentAccessToken() {
            if token.hasGranted("publish_actions") {
                successHandler(nil, token.tokenString)
                return
            }

            loginManager.logInWithPublishPermissions(publishPermissions, handler: {
                (res, err) -> Void in
                if let error = err {
                    failureHandler(error)
                }

                if let result = res {
                    if result.isCancelled {
                        failureHandler(nil)
                    }

                    successHandler(result, result.token.tokenString)

                } else {
                    failureHandler(CustomErrors.SocialFacebookResultNilError)
                }
            })
        } else {
            failureHandler(CustomErrors.SocialFacebookAccessTokenUnexpectedNilError)
        }
    }

    func logoutFacebook() {
        loginManager.logOut()
    }

    func getFacebookInvitableFriends(successHandler: [FacebookInvitableFriend] -> (), failureHandler: NSError -> ()) {

        var invitableFriends = [FacebookInvitableFriend]()

        var request = FBSDKGraphRequest(graphPath: "/me/invitable_friends?limit=1000&fields=id,name,picture.type(large)", parameters: nil)
        request.startWithCompletionHandler {
            (connection, result, error) -> Void in
            if let e = error {
                failureHandler(e)
            }

            if let res = result as? [String:AnyObject] {
                if let invitableFriendsArray = res["data"] as? [[String:AnyObject]] {
                    for invitableFriendObject in invitableFriendsArray {
                        if let friendStruct = FacebookInvitableFriend.decode(JSON.parse(invitableFriendObject)).value {
                            invitableFriends.append(friendStruct)
                        }
                    }
                    successHandler(invitableFriends)
                    return
                }
                successHandler(invitableFriends)
            } else {
                failureHandler(CustomErrors.SocialFacebookInvitableFriendsDataMalformedError)
            }
        }
    }

    func showAppRequestDialogWithInvitableFriends(invitableFriends: [FacebookInvitableFriend], customMessage: String, delegate: FBSDKGameRequestDialogDelegate, isGameRequest: Bool = false) {
        var inviteTokens = invitableFriends.map {
            return $0.inviteToken
        }

        log.info("About to show facebook dialog to \(inviteTokens)")

        var appRequestContent = FBSDKGameRequestContent()
        appRequestContent.message = customMessage
        appRequestContent.recipients = inviteTokens

        if isGameRequest {
            appRequestContent.actionType = .Turn
        }

        var appRequestDialog = FBSDKGameRequestDialog()
        appRequestDialog.content = appRequestContent
        appRequestDialog.frictionlessRequestsEnabled = true
        appRequestDialog.delegate = delegate

        self.appRequestDialog = appRequestDialog

        if self.appRequestDialog.canShow() {
            self.appRequestDialog.show()
        }
    }
}
