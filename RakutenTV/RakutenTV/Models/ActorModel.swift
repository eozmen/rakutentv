//
//  ActorModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ActorModel: NSObject{
    var type : String?
    var actorID : String?
    var numerical_id : Int?
    var photo : String?
    var name : String?
    var born_at : String?
    
    
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        if let val = dictionary["actorID"]{
            self.actorID = val as? String
        }
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        if let val = dictionary["photo"]{
            self.photo = val as? String
        }
        
        if let val = dictionary["name"]{
            self.name = val as? String
        }
        
        if let val = dictionary["born_at"]{
            self.born_at = val as? String
        }
        
    }
}
