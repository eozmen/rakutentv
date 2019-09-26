//
//  GenreModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class GenreModel: NSObject{
    var type : String?
    var genreID : String?
    var numerical_id : Int?
    var name : String?
    var adult : Bool?
    var erotic : Bool?
    var icon : String?
    
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{  
            self.type = val as? String
        }
        if let val = dictionary["id"]{  
            self.genreID = val as? String
        }
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        if let val = dictionary["name"]{  
            self.name = val as? String
        }
        if let val = dictionary["adult"] {
            self.adult = val as? Bool
        }
        if let val = dictionary["erotic"] {
            self.erotic = val as? Bool
        }
        if let val = dictionary["additional_images"]{
            if let valIcon = (val as! [String:Any])["icon"], !(valIcon is NSNull), (valIcon as! String).count > 0  {
                self.icon = valIcon as? String
            }
            
        }
    }
}
