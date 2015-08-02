//
//  TwitterOAuthCredential.swift
//  TradeHero
//
//  Created by Ryne Cheow on 29/5/15.
//  Copyright (c) 2015 TradeHero. All rights reserved.
//

struct TwitterOAuthCredential {
    let oauthToken: String!
    let oauthTokenSecret: String!
    let userId: String!
    let screenName: String!

    init(oauthToken: String!, oauthTokenSecret: String!, userId: String!, screenName: String!) {
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.userId = userId
        self.screenName = screenName
    }
}