//
//  IssueCell.swift
//  issueApp
//
//  Created by STA1_KANGJW on 2017. 11. 4..
//  Copyright © 2017년 STA1_KANGJW. All rights reserved.
//

import UIKit

class IssueCell: UICollectionViewCell {
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var commentCountButton: UIButton!
    
}


extension IssueCell{
    static var cellFromNib: IssueCell {
        guard let cell = Bundle.main.loadNibNamed("IssueCell", owner: nil, options: nil)?.first as? IssueCell else{ return IssueCell()}
        return cell;
    }
    
    func update(data issue: Model.Issue){
        titleLabel.text =  issue.title
        let createdAt = issue.createdAt?.string(dateFormat: "dd MMM") ?? "-"
        contentLabel.text = "#\(issue.number) \(issue.state.rawValue) on \(createdAt) by \(issue.user.login)"
        commentCountButton.setTitle("\(issue.comments)", for: .normal)
        stateButton.isSelected = issue.state == .closed
        let commentCountHidden: Bool = issue.comments == 0
        commentCountButton.alpha = commentCountHidden ? 0 : 1
    }
}

extension Date {
    func string(dateFormat: String, locale: String = "en-US") -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        format.locale = Locale(identifier: locale)
        return format.string(from: self)
    }
}
