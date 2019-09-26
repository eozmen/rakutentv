//
//  ScoreListCell.swift
//  RakutenTV
//
//  Created by Queen on 8.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class ScoreListCell: BaseCell{
    
    
    let contentTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight(rawValue: 2.0))
        label.numberOfLines = 0
        return label
    }()
    
    var ScoreListViewModel : ScoreListViewModel? {
        didSet{
            
            var xIndex : CGFloat = 0
            
            for (_,item) in (ScoreListViewModel?.showScores.enumerated())!{
                
                let scoreView = ScoreView()
                scoreView.scoreViewModel = ScoreViewModel(scoreModel: item)
                scoreView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(scoreView)
                
                
                scoreView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 10).isActive = true
                scoreView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: (xIndex)).isActive = true
                scoreView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                scoreView.widthAnchor.constraint(equalToConstant: 70).isActive = true
                
                xIndex += (70 + 20)
            }
            
            
            contentTitleLabel.text = "Valoracion"
        }
    }
    
    override func setupViews(){
        
        contentView.layoutMargins = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
        contentView.addSubview(contentTitleLabel)
        
        contentTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        contentTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        contentTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        
        
    }
    
}

