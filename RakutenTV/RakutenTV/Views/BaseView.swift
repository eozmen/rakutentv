//
//  BaseView.swift
//  RakutenTV
//
//  Created by Queen on 13.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    

}
