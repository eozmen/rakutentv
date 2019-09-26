//
//  InformationViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct InformationViewModel{
    
    var scoreString : String?
    var voteString : String?
    var restrictString : String?
    var yearString : String?
    
    init(movieModel: MovieModel){
        
        self.scoreString = ""
        self.voteString = ""
        self.restrictString = ""
        self.yearString = ""
        
        
        if let list = movieModel.scoreList{
            for item in list {
                if item.highlighted == true{
                    self.scoreString = item.score ?? ""
                    self.voteString = item.formatted_amount_of_votes ?? ""
                    break
                }
            }
        }
        
        if let val = movieModel.year {
            self.yearString = "\(val)"
        }
        
        if let classification = movieModel.classification{
            if let age = classification.age, age>0{
                self.restrictString = "+\(age)"
            }
            
        }
    }
}
