//
//  PromoContentCell.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class PromoContentCell: BaseCell {
    
    
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let labelContentTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight(rawValue: 2.0))
        return label
    }()
    
    var contentViewModel : ContentViewModel? {
        didSet{
            
            labelContentTitle.text = contentViewModel?.titleString
            imageView.imageFromURL(urlString: contentViewModel?.snapShotImage, defaultImage: nil, overlayColor: nil)
            
        }
    }
    
    override func setupViews(){
        
        contentView.addSubview(imageView)
        contentView.addSubview(labelContentTitle)
        
        self.selectedBackgroundView = UIView()
        
        
        imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        
        
        
        labelContentTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        labelContentTitle.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        labelContentTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        let gradient: CAGradientLayer = CAGradientLayer()        
        gradient.colors = [UIColor.clear.cgColor,UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0 ,0.7, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        imageView.layer.insertSublayer(gradient, at: 0)
        
        
    }
    
    
    
}


