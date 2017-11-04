//
//  IssuesViewController.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 11. 4..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import UIKit
import Alamofire

protocol DatsSourceRefreshable: class {
    associatedtype Item
    var dataSource: [Item]{
        get set
    }
    var needRefeshDataSource: Bool{get set}
}

extension DatsSourceRefreshable{
    
    func setNeedRefreshDatasource(){
        needRefeshDataSource = true
    }
    func refreshDataSourceIfNeeded(){
        if(needRefeshDataSource){
            dataSource = []
            needRefeshDataSource = false
        }
    }
}

class IssuesViewController: UIViewController, DatsSourceRefreshable {
    var needRefeshDataSource: Bool = false
    
    let owner: String = GlobalState.instance.owner
    let repo: String = GlobalState.instance.repo
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let estimateCell: IssueCell = IssueCell.cellFromNib
    
    var dataSource: [Model.Issue] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Dispose of any resources that can be recreated.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension IssuesViewController{
 
    func setup(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "IssueCell", bundle: nil), forCellWithReuseIdentifier: "IssueCell")
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        load()
    }
    
    func load(){
//        App.api.repoIssues(owner: owner, repo: repo){
//
//        }
    }
    
    func dataLoaded(items: [Model.Issue]){
        refreshDataSourceIfNeeded()
        refreshControl.endRefreshing()
        dataSource = items
        collectionView.reloadData()
    }
    
    func refresh(){
        setNeedRefreshDatasource()
        load()
    }
    
}

extension IssuesViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCell", for: indexPath) as? IssueCell else{ return IssueCell()}
        
        let data = dataSource[indexPath.item]
        cell.update(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            return UICollectionReusableView()
        default:
            assert(false, "unexpeted element Kind")
            return UICollectionReusableView()
        }
    }
    
}

extension IssuesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let data = dataSource[indexPath.item]
        estimateCell.update(data: data)
        let targetSize =  CGSize(width: collectionView.frame.width, height: 50)
        let estimatedSize = estimateCell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriorityRequired, verticalFittingPriority: UILayoutPriorityDefaultLow)
        return estimatedSize;
    }
}








