//
//  ListViewModel.swift
//  RakutenTV
//
//  Created by Queen on 14.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct ListViewModel {
    let titleString : String
    let contents : [ContentModel]
    
    
    init(list: ListModel) {
        titleString = list.short_name ?? ""
        contents = list.contentList ?? []
    }
    
}
