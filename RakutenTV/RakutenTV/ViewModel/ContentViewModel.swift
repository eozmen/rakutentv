//
//  ContentViewModel.swift
//  RakutenTV
//
//  Created by Queen on 14.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct ContentViewModel{

    var contentID : String
    var artworkImage : String
    var snapShotImage : String
    var scoreString : String
    var voteString : String
    var titleString : String
    var ribbons : [RibbonModel]
    
    init(contentModel: ContentModel){
        
        self.contentID = contentModel.contentID ?? ""
        self.artworkImage = ""
        self.snapShotImage = ""
        self.scoreString = ""
        self.voteString = ""
        self.titleString = contentModel.title ?? ""
        self.ribbons = []
        if let images = contentModel.images{
            if let imageURLString = images.artwork{
                self.artworkImage = imageURLString
            }
            if let imageURLString = images.snapshot{
                self.snapShotImage = imageURLString
            }
        }

        if let scoreModel =  contentModel.score{
            if let val = scoreModel.score{
                self.scoreString = val
            }
            if let val = scoreModel.formatted_amount_of_votes{
                
                self.voteString = val
            }
        }
        
        
        if let images = contentModel.images{
            if let list = images.ribbonList {
                self.ribbons = list
            }
            
        }
        
    }
}
