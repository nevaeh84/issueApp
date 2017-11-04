//
//  LoginViewController.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 10. 28..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    static var viewController: LoginViewController{
        guard let viewController = UIStoryboard(name:"main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return LoginViewController()
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPress(){
        App.api.getToken { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
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
