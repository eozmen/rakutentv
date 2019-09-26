//
//  BaseCell.swift
//  RakutenTV
//
//  Created by Queen on 13.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        contentView.layoutMargins = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
}
