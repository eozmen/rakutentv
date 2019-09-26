//
//  ClassificationModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ClassificationModel: NSObject{
    var type : String?
    var classificationID : String?
    var numerical_id : Int?
    var name : String?
    var age : Int?
    var adult : Bool?
    var classificationDescription: String?
    var classificationDefault : Bool?
    
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{  
            self.type = val as? String
        }
        if let val = dictionary["id"]{  
            self.classificationID = val as? String
        }
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        if let val = dictionary["name"]{  
            self.name = val as? String
        }
        if let val = dictionary["age"] {
            self.age = val as? Int
        }
        if let val = dictionary["adult"] {
            self.adult = val as? Bool
        }
        if let val = dictionary["description"]{  
            self.classificationDescription = val as? String
        }
        if let val = dictionary["default"] {
            self.classificationDefault = val as? Bool
        }
    }
}

