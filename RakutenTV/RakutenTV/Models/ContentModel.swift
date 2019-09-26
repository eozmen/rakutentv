//
//  ContentModel.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class ContentModel: NSObject {

    var type : String?
    var contentID : String?
    var numerical_id : Int?
    var title : String?
    var year : Int?
    var duration : Int?
    var label : String?
    var images : ImageModel?
    var ribbonList : [RibbonModel]?
//    var classification
//    var images
//    var highlighted_score
    var score : ScoreModel?
//    var labels
    
    override init() {
        super.init()
        
    }
    
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        
        if let val = dictionary["id"]{
            self.contentID = val as? String
        }
        
        if let val = dictionary["title"]{
            self.title = val as? String
        }
        
        if let val = dictionary["label"]{
            self.label = val as? String
        }
        
        if let val = dictionary["numerical_id"] {
            self.numerical_id = val as? Int
        }
        
        if let val = dictionary["year"] {
            self.year = val as? Int
        }
        
        if let val = dictionary["duration"] {
            self.duration = val as? Int
        }
        
        if let val = dictionary["images"]{
            self.images = ImageModel.init(dictionary: val as! [String : Any])
            
        }
        
        if let val = dictionary["highlighted_score"]{
            self.score = ScoreModel.init(dictionary: val as! [String : Any])
        }
        
        
    }
    
}
