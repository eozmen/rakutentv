//
//  ActorListViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct ActorListViewModel{
    
    var actors : [ActorModel]
    var directors : [ActorModel]
    
    init(movieModel: MovieModel){
        
        self.actors = []
        for item in movieModel.actorList ?? []{
            self.actors.append(item)
            
        }
        
        self.directors = []
        for item in movieModel.directorList ?? []{
            self.directors.append(item)
        }
        
        
    }
}
