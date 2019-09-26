//
//  ScoreListViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct ScoreListViewModel{
    var showScores : [ScoreModel]
    
    init(movieModel: MovieModel){
        
        self.showScores = []
        
        if let list = movieModel.scoreList{
            
            for (_,scoreItem) in list.enumerated(){
                if scoreItem.site?.show_image == false{
                    continue
                }
                
                self.showScores.append(scoreItem)
                
            }
            
        }
        
    }
}

