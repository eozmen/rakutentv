//
//  ApiController.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

struct CONNECTION {
    static let HOST = "https://gizmo.rakuten.tv"
    static let ROOT = HOST + "/v3/"
    
}

struct ENDPOINT {
    static var LIST = "lists/estrenos-imprescindibles-en-taquilla"
    static var MOVIES = "movies/"
    static var STREAMING = "me/streamings"
}

class ApiController: NSObject {

    class func getPlayerParameters(contentID:String) -> [String:String]{
        
        return ["audio_language":"SPA",
        "audio_quality":"2.0",
        "content_id":contentID,
        "content_type":"movies",
        "device_serial":"AABBCCDDCC112233",
        "device_stream_video_quality":"FHD",
        "player":"ios:PD-NONE",
        "subtitle_language":"MIS",
        "video_type":"trailer"]
        
        
    }
    class func getParameters() -> [String:String]{
        
        return ["classification_id":"6",
                "device_identifier":"ios",
                "locale":"es",
                "market_code":"es"]
        
    }
    
    class func addParameters(_ params: [String:String]) -> String{
        let parameters = params.sorted(by: { $0.key < $1.key })
        var urlParam = ""
        
        for (key, value) in parameters{
            
            if urlParam.count > 0 {
                urlParam += "&"
            }
            
            urlParam += "\(key)=\(value)"
        }
        return urlParam
    }
    
    
    class func rakutenTrailer(contentID:String, completion:@escaping (_ stream:StreamingModel?, _ isSucceeded:Bool,_ errorMessage: String?)->Void){
        
        let url = URL(string: CONNECTION.ROOT + ENDPOINT.STREAMING + "?" + addParameters(getParameters()) + "&" + addParameters(getPlayerParameters(contentID: contentID)))!
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion(nil, false, "\(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    
                }
                
                if let json = (try? JSONSerialization.jsonObject(with: data!)) as? [String: Any]{
                    
                    if let responseData = json["data"]{
                        
                        let stream = StreamingModel.init(dictionary: responseData as! [String : Any])
                        
                        completion(stream,true,nil)
                    }
                    if let errors = json["errors"]{
                        let errorData = (errors as! [Any]) as! [[String:Any]]
                        
                        if let errorString = errorData.first!["message"]{
                            completion(nil,false,"\(errorString)")
                            return
                        }
                        completion(nil,false,"Something bad happened")
                    }
                }
                
            }
        }
        task.resume()
    }
    class func rakutenLists(completion:@escaping (_ listModel:ListModel?, _ isSucceeded:Bool,_ errorMessage: String?)->Void){
        
        let url = URL(string: CONNECTION.ROOT + ENDPOINT.LIST + "?" + addParameters(getParameters()))!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion(nil, false, "\(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    
                }
                
                if let json = (try? JSONSerialization.jsonObject(with: data!)) as? [String: Any]{
                
                    if let responseData = json["data"]{
                    
                        let list = ListModel.init(dictionary: responseData as! [String : Any])
                    
                        completion(list,true,nil)
                    }
                }
                
            }
        }
        task.resume()
    }
    
    
    class func rakutenMovie(contentID:String, completion:@escaping (_ movie:MovieModel?, _ isSucceeded:Bool,_ errorMessage: String?)->Void){
        
        let url = URL(string: CONNECTION.ROOT + ENDPOINT.MOVIES + "/\(contentID)" + "?" + addParameters(getParameters()))!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion(nil, false, "\(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    
                }
                
                if let json = (try? JSONSerialization.jsonObject(with: data!)) as? [String: Any]{
                    
                    if let responseData = json["data"]{
                        
                        let content = MovieModel.init(dictionary: responseData as! [String : Any])
                        
                        completion(content,true,nil)
                    }
                }
                
            }
        }
        task.resume()
    }
}
