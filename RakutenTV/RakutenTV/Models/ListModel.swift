//
//  ListModel.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    
    var type : String?
    var listID : String?
    var numerical_id : Int?
//    "category": null,
    var short_name : String?
    var content_type : String?
    var is_b2b : Bool?
//    "wktv_code": null,
    var only_coupon : Bool?
    var kind : String?
    var is_recommendation : Bool?
    var name : String?

    var contentList : [ContentModel]?
    
    override init() {
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        
        if let val = dictionary["id"]{
            self.listID = val as? String
        }
        
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        
        if let val = dictionary["short_name"]{
            self.short_name = val as? String
        }
        
        if let val = dictionary["content_type"]{
            self.content_type = val as? String
        }
        
        
        if let val = dictionary["is_b2b"] {
            self.is_b2b = val as? Bool
        }
        if let val = dictionary["only_coupon"] {
            self.only_coupon = val as? Bool
        }
        
        if let val = dictionary["kind"]{
            self.kind = val as? String
        }
        
        if let val = dictionary["is_recommendation"] {
            self.is_recommendation = val as? Bool
        }
        
        if let val = dictionary["contents"]
        {
            if let list = (val as! [String:Any])["data"]
            {
                self.contentList = []
                
                for item in list as! [[String:AnyObject]] {
                    let model = ContentModel.init(dictionary: item)
                    self.contentList?.append(model)
                }


            }
            
        }
    }
    
}
