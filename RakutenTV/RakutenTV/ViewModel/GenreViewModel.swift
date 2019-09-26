//
//  GenreViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


struct GenreViewModel{
    
    var titleString : String?
    var imageString : String?
    
    init(genreModel: GenreModel){
        self.titleString = genreModel.name ?? ""
        self.imageString = genreModel.icon ?? ""
        
        
    }
}
