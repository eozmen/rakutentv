//
//  MovieModel.swift
//  RakutenTV
//
//  Created by Queen on 7.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class MovieModel: ContentModel {
    
    var original_title : String?
    var short_plot : String?
    var plot : String?
    var duration_in_seconds: Int?
    var ultraviolet_enabled : Bool?
    var genreList : [GenreModel]?
    var actorList : [ActorModel]?
    var directorList : [ActorModel]?
    var scoreList : [ScoreModel]?
    var classification : ClassificationModel?
    
    
    override init() {
        super.init()
        
    }
    
    
    override init(dictionary: [String:Any]){
        super.init(dictionary: dictionary)
        
        if let val = dictionary["original_title"]{  
            self.original_title = val as? String
        }
        
        if let val = dictionary["short_plot"]{  
            self.short_plot = val as? String
        }
        if let val = dictionary["plot"]{  
            self.plot = val as? String
        }
        
        if let val = dictionary["duration_in_seconds"] {
            self.duration_in_seconds = val as? Int
        }
        
        if let val = dictionary["ultraviolet_enabled"] {
            self.ultraviolet_enabled = val as? Bool
        }
        
        if let val = dictionary["actors"]
        {
            self.actorList = []
            
            for item in val as! [[String:Any]] {
                let model = ActorModel.init(dictionary: item)
                self.actorList?.append(model)
            }
        }
        
        if let val = dictionary["directors"]
        {
            self.directorList = []
            
            for item in val as! [[String:Any]] {
                let model = ActorModel.init(dictionary: item)
                self.directorList?.append(model)
            }
        }
        
        
        if let val = dictionary["genres"]
        {
            self.genreList = []
            
            for item in val as! [[String:Any]] {
                let model = GenreModel.init(dictionary: item)
                self.genreList?.append(model)
            }
        }
        if let val = dictionary["scores"]
        {
            self.scoreList = []
            
            for item in val as! [[String:Any]] {
                let model = ScoreModel.init(dictionary: item)
                self.scoreList?.append(model)
            }
        }
        
        if let val = dictionary["classification"]
        {
            self.classification = ClassificationModel.init(dictionary: val as! [String : Any])
        }
    }
    
}
