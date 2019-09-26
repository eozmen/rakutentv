//
//  ImageModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ImageModel: NSObject{
    var snapshot: String?
    var artwork: String?
    var ribbonList: [RibbonModel]?
    
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["snapshot"]{
            self.snapshot = val as? String
        }
        if let val = dictionary["artwork"]{
            self.artwork = val as? String
        }
        
        
        if let val = dictionary["ribbons"] {
            
            self.ribbonList = []
            
            for item in val as! [[String:AnyObject]] {
                let model = RibbonModel.init(dictionary: item)
                self.ribbonList?.append(model)
            }
        }
    }
}
