//
//  RepoViewController.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 11. 4..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet var ownerTextField: UITextField!
    @IBOutlet var repoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ownerTextField.text = GlobalState.instance.owner
        repoTextField.text = GlobalState.instance.repo
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "EnterRepoSegue", let owner = ownerTextField.text, let repo = repoTextField.text  {
            return !(owner.isEmpty || repo.isEmpty)
        }
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnterRepoSegue" {
            guard let owner = ownerTextField.text, let repo = repoTextField.text else { return }
            GlobalState.instance.owner = owner
            GlobalState.instance.repo = repo
            GlobalState.instance.addRepo(owner: owner, repo: repo)
            
        }
    }
    
}

extension RepoViewController{
    
    @IBAction func logoutButtonTapped(_ sender:Any){
        GlobalState.instance.token = ""
        let loginViewController =  LoginViewController.viewController
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {[weak self] in
            self?.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromRepos(_ segue: UIStoryboardSegue){
        guard let reposViewController = segue.source as? ReposViewController else{
            return
        }
        
        guard let (owner, repo) = reposViewController.selectedRepo else {return}
        
        ownerTextField.text = owner
        repoTextField.text =  repo
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {[weak self] in
            self?.performSegue(withIdentifier: "EnterRepoSegue", sender: nil)
        }
    }
}
