//
//  ContentListViewModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct ContentListViewModel{
    
    var contents : [ContentModel]
    
    init(listModel: ListModel) {
        
        self.contents = []
        for item in listModel.contentList!{
            self.contents.append(item)
        }
        
    }
    
}
