//
//  TopBarView.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class TopBarView: BaseView {

    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.text = "3.2"
        return label
    }()
    
    
    
    let searchButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        
        let imageview = UIImageView(image: UIImage(named: "icn_search"))
        imageview.setImageColor(color: .white)
        button.setImage(imageview.image, for: .normal)
        
        return button
    }()
    
    
    override func setupViews(){
        
        backgroundColor = .clear
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        insertSubview(visualEffectView, at: 0)
        addSubview(titleLabel)
        addSubview(searchButton)
        
        
        visualEffectView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        
        searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.text = "PORTADA"
    }

}
