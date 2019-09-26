//
//  ActorsCell.swift
//  RakutenTV
//
//  Created by Queen on 9.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class ActorsCell: BaseCell{
    
    let actorTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        
        return label
    }()

    let actorImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var actorViewModel : ActorViewModel? {
        didSet{
            
            actorTitle.text = actorViewModel?.titleString
            
            actorImage.imageFromURL(urlString: actorViewModel?.imageString, defaultImage: nil, overlayColor:nil)
            
        }
    }
    
    override func setupViews(){
        
        addSubview(actorTitle)
        addSubview(actorImage)
        
        
        actorImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        actorImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        actorImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        actorImage.heightAnchor.constraint(equalToConstant: 140).isActive = true
        actorImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        actorImage.bottomAnchor.constraint(equalTo: self.actorTitle.topAnchor, constant: 0).isActive = true
        
        
        actorTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        actorTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        actorTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        backgroundColor = rakutenCellBackground
    }
    
}

