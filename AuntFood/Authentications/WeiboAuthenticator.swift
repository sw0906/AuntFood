//
//  WeiboAuthenticator.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

import SSKeychain

struct WeiboAuthenticator: AuthenticatorProtocol, DebugPrintable {
    static var keychainAccountName: String {
        get {
            return "TradeHeroWeiboKeychainIdentifier"
        }
    }

    private var _cred: String!

    internal var authenticationHeaderPrefix: String {
        return "TH-Weibo"
    }

    var authenticationCredential: String {
        get {
            return "\(authenticationHeaderPrefix) \(_cred)"
        }
    }

    init?(oauthToken: String) {
        _cred = oauthToken
    }

    var debugDescription: String {
        return "< WeiboAuthenticator - \(authenticationCredential)) >"
    }

    var networkType: SocialNetworkType {
        return .Weibo
    }

    func saveCredentialToKeychain() {
        SSKeychain.setPassword(_cred, forService: kKeychainIdentifierKey, account: WeiboAuthenticator.keychainAccountName)
    }

    var credentialDictionary: [String:String] {
        return ["weibo_access_token": _cred]
    }
}
