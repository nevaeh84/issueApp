//
//  ReposViewController.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 11. 4..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let dataSource:[(owner:String, repo: String)] = GlobalState.instance.repos
    
    var selectedRepo: (owner: String, repo: String)?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ReposViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        let data = dataSource[indexPath.row]
        cell.textLabel?.text = "/\(data.owner)/\(data.repo)"
        
        return cell
    }
}

extension ReposViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let data = dataSource[indexPath.row]
        selectedRepo =  data
        self.performSegue(withIdentifier: "unwindToIssue", sender: self)
    }
}






















