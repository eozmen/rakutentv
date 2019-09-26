//
//  GenreListViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit



struct GenreListViewModel{
    var genres : [GenreModel]
    
    init(movieModel: MovieModel){
        
        self.genres = []
        for item in movieModel.genreList ?? []{
            self.genres.append(item)
        }
        
        
    }
}
