//
//  ContentCell.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ContentCell: BaseCell {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    
    
    let contentInfoView : ContentInformationShortView = {
        let view = ContentInformationShortView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let ribbonLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    var contentViewModel : ContentViewModel? {
        
        didSet {
            
            imageView.imageFromURL(urlString: contentViewModel?.artworkImage, defaultImage: nil, overlayColor: nil)
            contentInfoView.score = contentViewModel?.scoreString
            contentInfoView.vote = contentViewModel?.voteString
            
            ribbonLabel.isHidden = true
            for ribbon in contentViewModel!.ribbons{
                
                ribbonLabel.text = ribbon.localized_name
                ribbonLabel.backgroundColor = UIColor().hexStringToUIColor(hex: ribbon.color!)
                ribbonLabel.frame = CGRect(x:5,y:5,width: ribbonLabel.intrinsicContentSize.width + 10,height: 20)
                ribbonLabel.isHidden = false
            }

        }
    }
    
    
    override func setupViews(){
        
        self.selectedBackgroundView = UIView()
        
        contentView.addSubview(imageView)
        contentView.addSubview(contentInfoView)
        contentView.addSubview(ribbonLabel)
        
        imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentInfoView.topAnchor, constant: -5).isActive = true
        
        contentInfoView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        contentInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        contentInfoView.heightAnchor.constraint(equalToConstant: CELLHEIGHT_INFORMATION).isActive = true
        
    }
    
}


