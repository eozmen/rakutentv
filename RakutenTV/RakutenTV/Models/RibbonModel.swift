//
//  RibbonModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class RibbonModel: NSObject{
    var type: String?
    var ribbonID: String?
    var numerical_id: Int?
    var name: String?
    var image: String?
    var localized_name: String?
    var position : String?
    var color : String?
    
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        if let val = dictionary["id"]{
            self.ribbonID = val as? String
        }
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        if let val = dictionary["name"]{
            self.name = val as? String
        }
        if let val = dictionary["image"]{
            self.image = val as? String
        }
        if let val = dictionary["localized_name"]{
            self.localized_name = val as? String
        }
        if let val = dictionary["position"]{
            self.position = val as? String
        }
        if let val = dictionary["color"]{
            self.color = val as? String
        }
    }
}
