//
//  Helper.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class Helper {    
    
    class func gradientLayer() -> CAGradientLayer{
        var gl:CAGradientLayer!
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
        
        gl = CAGradientLayer()
        gl.colors = [colorTop,colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        
        return gl
    }
}


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    public func imageFromURL(urlString: String?, defaultImage : String?, overlayColor: UIColor?) {
        
        image = nil
        
        if let di = defaultImage {
            self.image = UIImage(named: di)
        }
        if  urlString == nil{
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString! as NSString){
            self.image = imageFromCache
            
            if overlayColor != nil{
                
                self.setImageColor(color: overlayColor!)
            }
            return
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString!)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let imageToCache = UIImage(data: data!)
                
                imageCache.setObject(imageToCache!,forKey:urlString! as NSString)
                
                self.image = imageToCache
                
                if overlayColor != nil{
                    
                    self.setImageColor(color: overlayColor!)
                }
            })
            
        }).resume()
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UILayoutPriority {
    static var Low: Float { return 250.0 }
    static var High: Float { return 750.0 }
    static var Required: Float { return 1000.0 }
}

extension UICollectionViewFlowLayout {
    
    var collectionViewWidthWithoutInsets: CGFloat {
        get {
            guard let collectionView = self.collectionView else { return 0 }
            let collectionViewSize = collectionView.bounds.size
            let widthWithoutInsets = collectionViewSize.width
                - self.sectionInset.left - self.sectionInset.right
                - collectionView.contentInset.left - collectionView.contentInset.right
            return widthWithoutInsets
        }
    }
    
}
