//
//  ShowAllListButton.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ShowAllListButton: UIButton {

    var pressed : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        titleLabel!.font = UIFont.systemFont(ofSize: 18.0)
        setTitle("VER TODO >", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed!()
    }
    
}
