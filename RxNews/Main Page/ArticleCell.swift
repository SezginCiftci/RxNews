//
//  ArticleCell.swift
//  RxNews
//
//  Created by Sezgin Çiftci on 5.02.2023.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    func addDateAuthor(_ dateStr: String, _ authorStr: String) {
        let dateLabel = MakeProperty.makeLabel()
        let authorLabel = MakeProperty.makeLabel()
        contentView.addSubviewsFromExt(dateLabel, authorLabel)
        dateLabel.text = dateStr.convertString()
        authorLabel.text = authorStr
        dateLabel.anchor(top: newsImageView.bottomAnchor,
                         left: contentView.leftAnchor, paddingTop: 10,
                         paddingLeft: 10, paddingBottom: 10,
                         paddingRight: 10,
                         width: newsImageView.frame.size.width,
                         height: 20)
        authorLabel.anchor(top: dateLabel.bottomAnchor,
                           left: contentView.leftAnchor,
                           paddingTop: 10,
                           paddingLeft: 10,
                           paddingBottom: 10,
                           paddingRight: 10,
                           width: newsImageView.frame.size.width,
                           height: 20)
    }
}

