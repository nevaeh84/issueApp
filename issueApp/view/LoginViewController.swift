//
//  LoginViewController.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 10. 28..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
    
    let oauth:OAuth2Swift = OAuth2Swift(consumerKey: "989bfcae35ac94eae42c",
                                        consumerSecret: "6314de9cff2477f65a7991af35d305715a4c4fa0",
                                        authorizeUrl: "https://github.com/login/oauth/authorize",
                                        accessTokenUrl: "https://github.com/login/oauth/access_token",
                                        responseType: "code")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPress(){
        oauth.authorize(withCallbackURL: "issueApp://oauth-callback/github", scope: "user,repo", state: "state", success: {(credenial, _, _) in
            let token = credenial.oauthToken
            print("token: \(token)")
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
