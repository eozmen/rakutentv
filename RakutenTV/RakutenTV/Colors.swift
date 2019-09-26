//
//  Colors.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit
let rakutenYellow =  UIColor().color(250,226,76)
let rakutenBackgroundDarkGray = UIColor().color(30,26,31)
let rakutenGrayIcon = UIColor().color(180,176,181)
let rakutenScoreGreen = UIColor().color(132,193,60)
let rakutenCellBackground = UIColor().color(41,37,43)
let rakutenDetailCircleBackground = UIColor().color(80,76,81)

extension UIColor{
    public func color(_ red:CGFloat, _ green: CGFloat,_ blue: CGFloat) -> UIColor{
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    public func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
