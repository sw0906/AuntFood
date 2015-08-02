//
//  TwitterService.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

import TwitterKit
import XCGLogger

class TwitterService: NSObject {
    static let kTradeHeroTwitterConsumerKey = "sJY7n9k29TAhraq4VjDYeg"
    static let kTradeHeroTwitterConsumerSecret = "gRLhwCd3YgdaKKEH7Gwq9FI75TJuqHfi2TiDRwUHo"

    class var service: TwitterService {

        struct Singleton {
            static var onceToken: dispatch_once_t = 0
            static var instance: TwitterService!
        }

        dispatch_once(&Singleton.onceToken) {
            Singleton.instance = TwitterService()
        }

        return Singleton.instance
    }

    lazy var twitter: Twitter = {
        var t = Twitter.sharedInstance()
        t.startWithConsumerKey(TwitterService.kTradeHeroTwitterConsumerKey, consumerSecret: TwitterService.kTradeHeroTwitterConsumerSecret)
        return t
    }()

    func signInWithTwitterWithCompletionHandler(successHandler: TwitterOAuthCredential -> (), failureHandler: (NSError -> ()), viewController: UIViewController? = nil) {

        var twitterLoginCompletion: TWTRLogInCompletion = {
            (sess, error) -> Void in
            if let e = error {
                failureHandler(e)
            }

            if let session = sess {
                log.info("Signed in as \(session.userName)")
                var credential = TwitterOAuthCredential(oauthToken: session.authToken, oauthTokenSecret: session.authTokenSecret, userId: session.userID, screenName: session.userName)
                successHandler(credential)
            } else {
                failureHandler(CustomErrors.SocialTwitterAuthSessionNilError)
            }
        }

        if let vc = viewController {
            twitter.logInWithViewController(vc, completion: twitterLoginCompletion)
        } else {
            twitter.logInWithCompletion(twitterLoginCompletion)
        }
    }

}

