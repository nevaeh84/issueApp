//
//  Model.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 11. 4..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Model {
    
}
extension Model{

    struct Issue {
        let id: Int
        let number: Int
        let title: String
        let user: Model.User
        let comments: Int
        let createdAt: Date?
        let updatedAt: Date?
        let closedAt: Date?
        let state: State
        let body: String
        
        init(json: JSON){
            id = json["id"].intValue
            number = json["number"].intValue
            title = json["title"].stringValue
            user = Model.User(json: json["user"])
            state = State(rawValue: json["state"].stringValue) ?? .open
            comments = json["comments"].intValue
            body = json["body"].stringValue
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            createdAt = format.date(from: json["created_at"].stringValue)
            updatedAt = format.date(from: json["updated_at"].stringValue)
            closedAt = format.date(from: json["closed_at"].stringValue)
        }
    }
    
    
}

extension Model.Issue{
    enum State: String{
        case open
        case closed
    }
}

extension Model {
    struct User {
        let id: String
        let login: String
        let avartarURL: URL?
        
        init(json: JSON){
            id = json["id"].stringValue
            login = json["login"].stringValue
            avartarURL = URL(string: json["avartal_url"].stringValue)
        }
    }
}





