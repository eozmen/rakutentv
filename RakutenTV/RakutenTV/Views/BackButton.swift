//
//  Backswift
//  RakutenTV
//
//  Created by Queen on 12.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    var pressed : (() -> Void)?
    
    func setupViews(){
        
        
        
        let window = UIApplication.shared.keyWindow
        var topAnchorValue : CGFloat = 0
        if let topAnchor = window?.safeAreaInsets.top{
            topAnchorValue += topAnchor
        }
        
        frame = CGRect(x:5,y:topAnchorValue,width:25,height:25)
        
        tintColor = .white
        let imageview = UIImageView(image: UIImage(named: "icn_back"))
        imageview.setImageColor(color: .white)
        setImage(imageview.image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed!()
    }
}
