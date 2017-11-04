//
//  API.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 10. 28..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

protocol API {
    typealias IssueResponsesHandler = (DataResponse<[Model.Issue]>) -> Void
    func getToken(handler: @escaping (() -> Void))
    func tokenRefresh(handler: @escaping (() -> Void))
    func repoIssues(owner: String, repo: String) -> (Int, @escaping IssueResponsesHandler) -> Void
    
}







