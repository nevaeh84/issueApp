//
//  GiHubApi.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 11. 4..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import OAuthSwift
import Alamofire
import Foundation
import SwiftyJSON

struct GithubAPI:API{
    let oauth:OAuth2Swift = OAuth2Swift(consumerKey: "989bfcae35ac94eae42c",
                                        consumerSecret: "6314de9cff2477f65a7991af35d305715a4c4fa0",
                                        authorizeUrl: "https://github.com/login/oauth/authorize",
                                        accessTokenUrl: "https://github.com/login/oauth/access_token",
                                        responseType: "code")
    func getToken(handler: @escaping (() -> Void)){
        oauth.authorize(withCallbackURL: "issueApp://oauth-callback/github", scope: "user,repo", state: "state", success: {(credenial, _, _) in
            let token = credenial.oauthToken
            let refreshToken = credenial.oauthRefreshToken
            GlobalState.instance.token = token
            GlobalState.instance.refrestoken = refreshToken
            print("token: \(token)")
            handler()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func tokenRefresh(handler: @escaping (() -> Void)){
        guard let refreshToken = GlobalState.instance.refrestoken else {return}
        oauth.renewAccessToken(withRefreshToken: refreshToken, success: { (credenial, _, _) in
            let token = credenial.oauthToken
            let refreshToken = credenial.oauthRefreshToken
            GlobalState.instance.token = token
            GlobalState.instance.refrestoken = refreshToken
            print("token: \(token)")
            handler()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    typealias IssuesResponseHandler = (DataResponse<[Model.Issue]>)
    func repoIssues(owner: String, repo: String) -> (Int, @escaping IssueResponsesHandler) -> Void {
        return { (page, handler) in
            let parameters: Parameters = ["page": page, "state": "all"]
            GitHubRouter.manager.request(GitHubRouter.repoIssues(owner: owner, repo: repo, parameters: parameters)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
                let result = dataResponse.map({ (json: JSON) -> [Model.Issue] in
                    return json.arrayValue.map {
                        Model.Issue(json: $0)
                    }
                })
                handler(result)
            }
        }
    }
}
