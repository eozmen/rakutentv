//
//  ActorViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit



struct ActorViewModel{
    
    var titleString : String?
    var imageString : String?
    
    init(actorModel: ActorModel){
        self.titleString = actorModel.name ?? ""
        self.imageString = actorModel.photo ?? ""
        
        
    }
}
