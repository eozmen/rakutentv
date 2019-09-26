//
//  ScoreModel.swift
//  RakutenTV
//
//  Created by Queen on 7.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class ScoreModel: NSObject{
    var type : String?
    var scoreID : String?
    var numerical_id : Int?
    var href : String?
    var amount_of_votes : Int?
    var formatted_amount_of_votes : String?
    var score : String?
    var highlighted : Bool?
    var site : SiteModel?
    override init() {
        super.init()
        
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        if let val = dictionary["id"]{
            self.scoreID = val as? String
        }
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        if let val = dictionary["href"]{
            self.href = val as? String
        }
        if let val = dictionary["score"]{
            self.score = "\(CGFloat((val as? Double)!))"
        }
        if let val = dictionary["amount_of_votes"] {
            self.amount_of_votes = val as? Int
        }
        if let val = dictionary["formatted_amount_of_votes"]{
            self.formatted_amount_of_votes = val as? String
        }
        if let val = dictionary["highlighted"] {
            self.highlighted = val as? Bool
        }
        
        if let val = dictionary["site"] {
            self.site = SiteModel.init(dictionary: val as! [String : Any])
        }
    }
}
