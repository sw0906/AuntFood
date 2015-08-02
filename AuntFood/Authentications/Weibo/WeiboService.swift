//
// Created by Ryne Cheow on 2/6/15.
// Copyright (c) 2015 TradeHero. All rights reserved.
//

import SVProgressHUD

class WeiboService: NSObject, WeiboSDKDelegate {

    var successHandler: String! -> ()
    var failureHandler: NSError! -> ()

    init(successHandler: String! -> (), failureHandler: NSError! -> ()) {
        self.successHandler = successHandler
        self.failureHandler = failureHandler
    }


    func authenticateWithWeibo() {
        var appDelegate = UIApplication.sharedApplication().delegate as? THAppDelegate
        if let appDel = appDelegate {
            appDelegate?.weiboSDKDelegate = self
        }

        var request = WBAuthorizeRequest()
        request.redirectURI = "http://en.tradehero.mobi"
        request.scope = "all"
        WeiboSDK.sendRequest(request)

        if !WeiboSDK.isWeiboAppInstalled() {
            SVProgressHUD.dismiss()
        }
    }

    func didReceiveWeiboRequest(request: WBBaseRequest!) {

    }

    func didReceiveWeiboResponse(res: WBBaseResponse!) {
        if res is WBAuthorizeResponse {
            if let response = res as? WBAuthorizeResponse {
                if response.userID == nil {
                    self.failureHandler(CustomErrors.SocialWeiboAuthFailedError)
                } else {
                    self.successHandler(response.accessToken)
                }
            }
        }
    }
}
