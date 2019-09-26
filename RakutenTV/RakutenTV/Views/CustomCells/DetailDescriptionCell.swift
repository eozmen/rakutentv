//
//  DetailDescriptionCell.swift
//  RakutenTV
//
//  Created by Queen on 8.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class DetailDescriptionCell: BaseCell{
    
    
    let contentTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight(rawValue: 2.0))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let contentDescriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var descriptionViewModel : DescriptionViewModel? {
        didSet{
            contentTitleLabel.text = descriptionViewModel?.titleString
            contentDescriptionLabel.text = descriptionViewModel?.descriptionString

        }
    }
    override func setupViews(){
        
        contentView.layoutMargins = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
        
        contentView.addSubview(contentTitleLabel)
        contentView.addSubview(contentDescriptionLabel)
        
        
        
        contentTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        contentTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        contentTitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        contentTitleLabel.bottomAnchor.constraint(equalTo: contentDescriptionLabel.layoutMarginsGuide.topAnchor, constant: -10).isActive = true
        

        contentDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        contentDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        contentDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        
        contentTitleLabel.preferredMaxLayoutWidth = self.contentView.frame.size.width - self.layoutMargins.left - self.layoutMargins.right
        contentDescriptionLabel.preferredMaxLayoutWidth = self.contentView.frame.size.width - self.layoutMargins.left - self.layoutMargins.right
    }
    
    
}
