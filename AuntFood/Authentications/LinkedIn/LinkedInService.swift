//
//  LinkedInService.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

import XCGLogger
import OAuthSwift

class LinkedInService {
    static let kTradeHeroLinkedInConsumerKey = "afed437khxve"
    static let kTradeHeroLinkedInConsumerSecret = "hO7VeSyL4y1W2ZiK"

    func doOAuthLinkedin2(controllerToPresent: UIViewController) {
        let oauthswift = OAuth2Swift(consumerKey: LinkedInService.kTradeHeroLinkedInConsumerKey,
                consumerSecret: LinkedInService.kTradeHeroLinkedInConsumerSecret,
                authorizeUrl: "https://www.linkedin.com/uas/oauth2/authorization",
                accessTokenUrl: "https://www.linkedin.com/uas/oauth2/accessToken",
                responseType: "code"
        )

        let state: String = generateStateWithLength(20) as String

        oauthswift.authorizeWithCallbackURL(NSURL(string: "tradehero://linkedin.auth_token")!, scope: "r_basicprofile r_emailaddress w_share", state: state, success: {
            credential, response, parameters in
            self.showAlertView("Linkedin2", message: "oauth_token:\(credential.oauth_token)", controllerToPresent: controllerToPresent)
            var parameters = [String: AnyObject]()
            oauthswift.client.get("https://api.linkedin.com/v1/people/~?format=json", parameters: parameters,
                    success: {
                        data, response in
                        let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                        log.info(dataString as? String)
                    }, failure: {
                (error: NSError!) -> Void in
                log.error(error.localizedDescription)
            })
        }, failure: {
            (error: NSError!) -> Void in
            log.error(error.localizedDescription)
        })
    }


    func showAlertView(title: String, message: String, controllerToPresent: UIViewController) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: nil))
        controllerToPresent.presentViewController(alert, animated: true, completion: nil)
    }

}
