//
//  ContentInformationView.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ContentInformationBaseView : BaseView{
    
    let imageStar : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icn_detail_rating")
        imageView.setImageColor(color: rakutenYellow)
        return imageView
    }()
    
    let labelScore : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = rakutenYellow
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    let imageVote : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icn_detail_avatar")
        imageView.contentMode = .scaleAspectFit
        imageView.setImageColor(color: rakutenGrayIcon)
        return imageView
    }()
    
    let labelVote : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    
    let seperatorLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        
        return view
    }()
    
    let labelYear : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    
    var score : String? {
        didSet{
            
            labelScore.text = score
        }
    }
    var vote : String? {
        didSet{
            
            labelVote.text = vote
        }
    }
    var year : String? {
        didSet{
            
            labelYear.text = year
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        layoutMargins = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
}



class ContentInformationView: ContentInformationBaseView {

    let labelRestrict : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    
    var restrict : String? {
        didSet{
            
            labelRestrict.text = restrict
        }
    }
    
    override func setupViews(){
        addSubview(imageStar)
        addSubview(labelScore)
        addSubview(imageVote)
        addSubview(labelVote)
        addSubview(seperatorLine)
        addSubview(labelYear)
        addSubview(labelRestrict)
        
       addConstraintsWithFormat("H:|-[v0(14)]-3-[v1]-8-[v2(14)]-3-[v3]-8-[v4(1)]-8-[v5]-8-[v6]", views: imageStar,labelScore,imageVote,labelVote,seperatorLine, labelYear, labelRestrict)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: imageStar)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: labelScore)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: imageVote)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: labelVote)

        
        seperatorLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        seperatorLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: labelYear)
            
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: labelRestrict)

    }
    
}

class ContentInformationShortView: ContentInformationBaseView {
    
    
    override func setupViews(){
        
        addSubview(imageStar)
        addSubview(labelScore)
        addSubview(imageVote)
        addSubview(labelVote)
        
        addConstraintsWithFormat("H:|-[v0(14)]-3-[v1]-8-[v2(14)]-3-[v3]-|", views: imageStar,labelScore,imageVote,labelVote)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: imageStar)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: labelScore)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: imageVote)
        
        addConstraintsWithFormat("V:|-2-[v0(14)]", views: labelVote)
        
    }
    
}
