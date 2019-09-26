//
//  DetailFooterView.swift
//  RakutenTV
//
//  Created by Queen on 9.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class DetailFooterView: UICollectionReusableView {

    var pressed : (() -> Void)?
    
    let playButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(.black, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 20.0)
        button.setTitle("PLAY", for: .normal)
        
        button.tintColor = .black
        let imageview = UIImageView(image: UIImage(named: "icn_detail_play"))
        imageview.setImageColor(color: .black)
        
        button.setImage(imageview.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        return button
    }()
    
    
    func setupViews(){
        backgroundColor = rakutenYellow
        
        DispatchQueue.main.async {
            self.addSubview(self.playButton)
            self.playButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
            self.playButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
            self.playButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
            self.playButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        }

    }
    
}

