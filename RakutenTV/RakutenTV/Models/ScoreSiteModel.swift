//
//  SiteModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class SiteModel: NSObject{
    var type : String?
    var scoreSiteID : String?
    var numerical_id : Int?
    var name : String?
    var show_image : Bool?
    var scale : Int?
    var image : String?
    
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        if let val = dictionary["id"]{
            self.scoreSiteID = val as? String
        }
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        if let val = dictionary["name"]{
            self.name = val as? String
        }
        if let val = dictionary["show_image"] {
            self.show_image = val as? Bool
        }
        if let val = dictionary["scale"] {
            self.scale = val as? Int
        }
        if let val = dictionary["image"]{
            self.image = val as? String
        }
    }
}
