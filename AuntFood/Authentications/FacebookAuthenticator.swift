//
//  FacebookAuthenticator.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

import SSKeychain

struct FacebookAuthenticator: AuthenticatorProtocol, DebugPrintable {
    static var keychainAccountName: String {
        get {
            return "TradeHeroFacebookKeychainIdentifier"
        }
    }

    private var _cred: String!

    internal var authenticationHeaderPrefix: String {
        return "TH-Facebook"
    }

    var authenticationCredential: String {
        get {
            return "\(authenticationHeaderPrefix) \(_cred)"
        }
    }

    init?(accessToken: String) {
        _cred = accessToken
    }

    var debugDescription: String {
        return "< FacebookAuthenticator - \(authenticationCredential)) >"
    }

    var networkType: SocialNetworkType {
        return .Facebook
    }

    func saveCredentialToKeychain() {
        SSKeychain.setPassword(_cred, forService: kKeychainIdentifierKey, account: FacebookAuthenticator.keychainAccountName)
    }

    var credentialDictionary: [String:String] {
        return ["facebook_access_token": _cred]
    }
}
