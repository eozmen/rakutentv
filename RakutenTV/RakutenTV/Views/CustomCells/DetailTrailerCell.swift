//
//  DetailTrailerCell.swift
//  RakutenTV
//
//  Created by Queen on 8.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class DetailTrailerCell: BaseCell{
    
    let trailerButton : TrailerPlayButton = {
        let button = TrailerPlayButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func setupViews(){
        
        contentView.addSubview(trailerButton)
        
        trailerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        trailerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        trailerButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        
    }
    
}


class TrailerPlayButton : UIButton{
    
    var pressed : (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed!()
    }
    
    func setupViews(){
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        
        tintColor = .white
        
        let imageview = UIImageView(image: UIImage(named: "icn_detail_play_trailer"))
        imageview.setImageColor(color: .white)
        setImage(imageview.image, for: .normal)
        
        setTitle("TRAILER", for: .normal)
        
        if imageView != nil{
            imageView!.contentMode = .scaleAspectFit
        }
        
        
        contentEdgeInsets = UIEdgeInsets(top: 0,
                                         left: 20.0,
                                         bottom: 0,
                                         right: 20.0)
    }
    
}
