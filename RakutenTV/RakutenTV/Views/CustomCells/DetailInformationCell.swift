//
//  DetailInformationCell.swift
//  RakutenTV
//
//  Created by Queen on 8.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class DetailInformationCell: BaseCell{
    
    let contentInfoView : ContentInformationView = {
        let view = ContentInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    var informationViewModel : InformationViewModel? {
        didSet{
            
            contentInfoView.score = informationViewModel?.scoreString
            contentInfoView.vote = informationViewModel?.voteString
            contentInfoView.restrict = informationViewModel?.restrictString
            contentInfoView.year = informationViewModel?.yearString
    
        }
    }
    override func setupViews(){
        
        contentView.addSubview(contentInfoView)
        
        addConstraintsWithFormat("H:|-[v0]", views: contentInfoView)
        addConstraintsWithFormat("V:|[v0(\(CELLHEIGHT_INFORMATION))]", views: contentInfoView)
        
        
        
    }
    
    
}
