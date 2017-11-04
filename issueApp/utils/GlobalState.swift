//
//  GlobalState.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 10. 28..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import Foundation

final class GlobalState{

    static let instance = GlobalState() //싱글톤
    
    enum Constants:String {
        case tokenKey
        case refreshTokenKey
        case ownerKey
        case repoKey
         case reposKey
    }
    
    var token: String? {
        get{
            let token = UserDefaults.standard.string(forKey: Constants.tokenKey.rawValue)
            return token
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: Constants.tokenKey.rawValue)
        }
    }
    
    var refrestoken: String? {
        get{
            let token = UserDefaults.standard.string(forKey: Constants.refreshTokenKey.rawValue)
            return token
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: Constants.refreshTokenKey.rawValue)
        }
    }
    
    var owner: String {
        get {
            let owner = UserDefaults.standard.string(forKey: Constants.ownerKey.rawValue) ?? ""
            return owner
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.ownerKey.rawValue)
        }
    }
    var repo: String {
        get {
            let repo = UserDefaults.standard.string(forKey: Constants.repoKey.rawValue) ?? ""
            return repo
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.repoKey.rawValue)
        }
    }
    
    var isLoggedIn: Bool {
        let isEmpty = token?.isEmpty ?? false
        return !isEmpty
    }
    
    var repos: [(owner: String, repo:String)] {
        let repoDicts: [[String: String]] = (UserDefaults.standard.array(forKey: Constants.reposKey.rawValue) as? [[String : String]]) ?? []
        let repos = repoDicts.map { (repoDict: [String: String]) -> (String, String) in
            let owner = repoDict["owner"] ?? ""
            let repo = repoDict["repo"] ?? ""
            return (owner, repo)
        }
        return repos
    }
    
    //집합은 중복을 빼줌 어레이-> 집합-> 어레이
    func addRepo(owner: String, repo: String){
        let dict = ["owner": owner, "repo": repo]
        var repos: [[String: String]] = UserDefaults.standard.array(forKey: Constants.reposKey.rawValue) as? [[String: String]] ?? []
        repos.append(dict)
        
         UserDefaults.standard.set(NSSet(array: repos).allObjects, forKey: Constants.reposKey.rawValue)
    }
}
