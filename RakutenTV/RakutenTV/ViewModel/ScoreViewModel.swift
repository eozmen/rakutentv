//
//  ScoreViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct ScoreViewModel{
    
    var scoreString : String
    var voteString : String?
    var imageString : String?
    
    init(scoreModel: ScoreModel){
        self.scoreString = scoreModel.score ?? ""
        self.voteString = scoreModel.formatted_amount_of_votes ?? ""
        self.imageString = scoreModel.site?.image
        
        
    }
}
