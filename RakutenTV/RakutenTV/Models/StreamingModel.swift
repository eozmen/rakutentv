//
//  StreamingModel.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class StreamingModel: NSObject {
    
    var type : String?
    var streamID : String?
//    var plot : String?
    var streamInfoList : [StreamInfoModel]?
    
    
    override init() {
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["type"]{
            self.type = val as? String
        }
        
        if let val = dictionary["streamID"]{
            self.streamID = val as? String
        }
        if let val = dictionary["stream_infos"]
        {
            self.streamInfoList = []
            
            for item in val as! [[String:AnyObject]] {
                let model = StreamInfoModel.init(dictionary: item)
                self.streamInfoList?.append(model)
            }
        }
        
    }
    
}
