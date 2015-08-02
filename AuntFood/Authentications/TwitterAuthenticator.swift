//
//  TwitterAuthenticator.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

import SSKeychain

struct TwitterAuthenticator: AuthenticatorProtocol, DebugPrintable {
    static var keychainAccountName: String {
        get {
            return "TradeHeroTwitterKeychainIdentifier"
        }
    }

    private var _cred: String!
    private var oauthToken: String!
    private var oauthSecret: String!
    private var screenName: String!

    internal var authenticationHeaderPrefix: String {
        return "TH-Twitter"
    }

    var authenticationCredential: String {
        get {
            return "\(authenticationHeaderPrefix) \(_cred)"
        }
    }

    init?(oauthToken: String, oauthSecret: String, screenName: String? = nil) {
        _cred = "\(oauthToken):\(oauthSecret)"
        self.oauthToken = oauthToken
        self.oauthSecret = oauthSecret
        self.screenName = screenName
    }

    init?(oauthCredentials: String) {
        _cred = oauthCredentials
        var components = _cred.componentsSeparatedByString(":")
        if components.count == 2 {
            log.error("Splitted components must have 2 items!!")
            return nil
        }

        self.oauthToken = components[0]
        self.oauthSecret = components[1]
    }

    var debugDescription: String {
        return "< TwitterAuthenticator - \(authenticationCredential)) >"
    }

    var networkType: SocialNetworkType {
        return .Twitter
    }

    func saveCredentialToKeychain() {
        SSKeychain.setPassword(_cred, forService: kKeychainIdentifierKey, account: TwitterAuthenticator.keychainAccountName)
    }

    var credentialDictionary: [String:String] {

        var dictionary: [String:String] = ["twitter_access_token": oauthToken, "twitter_access_token_secret": oauthSecret]
        if let screenName = self.screenName {
            dictionary.updateValue(screenName, forKey: "twitter_screename")
        }
        return dictionary

    }
}
