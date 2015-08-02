//
//  LinkedInAuthenticator.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

import SSKeychain

struct LinkedInAuthenticator: AuthenticatorProtocol, DebugPrintable {
    static var keychainAccountName: String {
        get {
            return "TradeHeroLinkedInKeychainIdentifier"
        }
    }

    private var _cred: String!
    private var oauthToken: String!
    private var oauthSecret: String!

    internal var authenticationHeaderPrefix: String {
        return "TH-LinkedIn"
    }

    var authenticationCredential: String {
        get {
            return "\(authenticationHeaderPrefix) \(_cred)"
        }
    }

    init?(oauthToken: String, oauthSecret: String) {
        _cred = "\(oauthToken):\(oauthSecret)"
        self.oauthToken = oauthToken
        self.oauthSecret = oauthSecret
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
        return "< LinkedInAuthenticator- \(authenticationCredential)) >"
    }

    var networkType: SocialNetworkType {
        return .LinkedIn
    }

    func saveCredentialToKeychain() {
        SSKeychain.setPassword(_cred, forService: kKeychainIdentifierKey, account: LinkedInAuthenticator.keychainAccountName)
    }

    var credentialDictionary: [String:String] {
        return ["linkedin_access_token": oauthToken, "linkedin_access_token_secret": oauthSecret]

    }
}
