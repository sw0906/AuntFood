import SSKeychain
import Alamofire
import XCGLogger

let kKeychainIdentifierKey = "TradeHeroKeychainIdentifier"

class AuthenticationManager: NSObject {

    class var sharedManager: AuthenticationManager {

        struct Singleton {
            static var onceToken: dispatch_once_t = 0
            static var instance: AuthenticationManager!
        }

        dispatch_once(&Singleton.onceToken) {
            Singleton.instance = AuthenticationManager()
        }
        return Singleton.instance
    }

    private var auth: AuthenticatorProtocol!
    // return main authenticator if set, else check for any saved authenticator in keychain
    var authenticator: AuthenticatorProtocol! {
        get {
            if let main = auth {
                return main
            } else {
                if let fb = self.facebookAuthenticator {
                    auth = fb
                    return fb
                }

                if let tw = self.twitterAuthenticator {
                    auth = tw
                    return tw
                }

                if let li = self.linkedInAuthenticator {
                    auth = li
                    return li
                }

                if let wb = self.weiboAuthenticator {
                    auth = wb
                    return wb
                }
            }
            return nil
        }

        set(auth) {

            if auth is FacebookAuthenticator {
                self.facebookAuthenticator = auth as! FacebookAuthenticator
            }

            if auth is EmailAuthenticator {
                self.emailAuthenticator = auth as! EmailAuthenticator
            }

            if auth is TwitterAuthenticator {
                self.twitterAuthenticator = auth as! TwitterAuthenticator
            }

            if auth is LinkedInAuthenticator {
                self.linkedInAuthenticator = auth as! LinkedInAuthenticator
            }

            if auth is WeiboAuthenticator {
                self.weiboAuthenticator = auth as! WeiboAuthenticator
            }

            self.auth = auth
        }
    }

    //MARK: - Facebook
    private var fbAuth: FacebookAuthenticator!
    var facebookAuthenticator: FacebookAuthenticator! {
        get {
            //check memory
            if let fbAuthenticator = fbAuth {
                return fbAuthenticator
            } else {
                //check keychain
                if let credentials = getCredentialFromKeyChain(FacebookAuthenticator.keychainAccountName) {
                    if let fbAuthenticator = FacebookAuthenticator(accessToken: credentials) {
                        fbAuth = fbAuthenticator
                        return fbAuthenticator
                    }
                }
            }
            return nil
        }

        set {
            fbAuth = newValue
            fbAuth.saveCredentialToKeychain()
        }
    }

    //MARK: - Basic
    private var basicAuth: EmailAuthenticator!
    var emailAuthenticator: EmailAuthenticator! {
        get {
            //check memory
            if let basicAuthenticator = basicAuth {
                return basicAuth
            } else {
                //check keychain
                if let credentials = getCredentialFromKeyChain(EmailAuthenticator.keychainAccountName) {
                    if let basicAuthenticator = EmailAuthenticator(encodedCredentials: credentials) {
                        basicAuth = basicAuthenticator
                        return basicAuthenticator
                    }
                }
            }
            return nil
        }

        set {
            basicAuth = newValue
            basicAuth.saveCredentialToKeychain()
        }
    }

    //MARK: - Twitter
    private var twAuth: TwitterAuthenticator!
    var twitterAuthenticator: TwitterAuthenticator! {
        get {
            //check memory
            if let twitterAuthenticator = twAuth {
                return twitterAuthenticator
            } else {
                //check keychain
                if let credentials = getCredentialFromKeyChain(TwitterAuthenticator.keychainAccountName) {
                    if let twitterAuthenticator = TwitterAuthenticator(oauthCredentials: credentials) {
                        twAuth = twitterAuthenticator
                        return twitterAuthenticator
                    }
                }
            }
            return nil
        }

        set {
            twAuth = newValue
            twAuth.saveCredentialToKeychain()
        }
    }

    //MARK: - LinkedIn
    private var liAuth: LinkedInAuthenticator!
    var linkedInAuthenticator: LinkedInAuthenticator! {
        get {
            //check memory
            if let linkedInAuthenticator = liAuth {
                return linkedInAuthenticator
            } else {
                //check keychain
                if let credentials = getCredentialFromKeyChain(LinkedInAuthenticator.keychainAccountName) {
                    if let linkedInAuthenticator = LinkedInAuthenticator(oauthCredentials: credentials) {
                        liAuth = linkedInAuthenticator
                        return linkedInAuthenticator
                    }
                }
            }
            return nil
        }

        set {
            liAuth = newValue
            liAuth.saveCredentialToKeychain()
        }
    }


    //MARK: - Weibo
    private var wbAuth: WeiboAuthenticator!
    var weiboAuthenticator: WeiboAuthenticator! {
        //check memory
        get {
            if let wbAuthenticator = wbAuth {
                return wbAuthenticator
            } else {
                //check keychain
                if let credentials = getCredentialFromKeyChain(WeiboAuthenticator.keychainAccountName) {
                    if let wbAuthenticator = WeiboAuthenticator(oauthToken: credentials) {
                        wbAuth = wbAuthenticator
                        return wbAuthenticator
                    }
                }
            }
            return nil
        }

        set {
            wbAuth = newValue
            wbAuth.saveCredentialToKeychain()
        }
    }

    func authenticatedURLRequest(method: Alamofire.Method, URLString: Alamofire.URLStringConvertible) -> NSURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString.URLString)!)
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue(self.authenticator.authenticationCredential, forHTTPHeaderField: "Authorization")

        return mutableURLRequest
    }

    private func generateAuthenticationHeaderStringWithAuthenticator(auth: AuthenticatorProtocol) -> String {
        return "\(auth.authenticationHeaderPrefix) \(auth.authenticationCredential)"
    }

    private func getCredentialFromKeyChain(account: String) -> String! {
        if let keychainAcc = SSKeychain.accountsForService(kKeychainIdentifierKey) {
            if keychainAcc.count == 0 {
                log.debug("No credentials found")
                return nil
            }

            for userData in keychainAcc {
                if let data = userData as? [String:AnyObject] {
                    return SSKeychain.passwordForService(kKeychainIdentifierKey, account: account)
                }
            }
        }
        return nil
    }

}
