//
//  DetailViewModel.swift
//  RakutenTV
//
//  Created by Queen on 14.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct DetailViewModel {
    
    var movieModel : MovieModel
    var showScore : Bool = false
    
    init(movieModel: MovieModel) {
    
        self.movieModel = movieModel
        
        showScore = false
        
        if let list = movieModel.scoreList{
            for item in list {
                if item.site?.show_image == true{
                    showScore = true
                    break
                }
            }
        }
    }
}




