//
//  DescriptionViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct DescriptionViewModel{
    
    var titleString : String?
    var descriptionString : String?
    
    init(movieModel: MovieModel){
        self.titleString = movieModel.original_title
        self.descriptionString = movieModel.short_plot
        
        
    }
}
