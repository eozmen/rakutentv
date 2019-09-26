//
//  StreamingInfoModel.swift
//  RakutenTV
//
//  Created by Queen on 15.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class StreamInfoModel: NSObject {
    
    var player : String?
    var display_aspect_ratio : CGFloat?
    var cdn : String?
    var url : String?
    var wrid : String?
    var video_quality : String?
    
    var scoreList : [StreamInfoModel]?
    
    
    override init() {
    }
    
    init(dictionary: [String:Any]){
        
        if let val = dictionary["player"]{
            self.player = val as? String
        }
        if let val = dictionary["display_aspect_ratio"]  {
            self.display_aspect_ratio = val as? CGFloat
        }
        if let val = dictionary["cdn"]{
            self.cdn = val as? String
        }
        if let val = dictionary["url"]{
            self.url = val as? String
        }
        if let val = dictionary["wrid"]{
            self.wrid = val as? String
        }
        if let val = dictionary["video_quality"]{
            self.video_quality = val as? String
        }
    }
}
