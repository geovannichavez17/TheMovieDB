//
//  UIColor+Extensions.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import UIKit

extension UIColor {
    
    static let transparentBlack = UIColor(named: "transparentBlack")!
    
    @nonobjc class var dark: UIColor {
      return UIColor(red: 26.0 / 255.0, green: 40.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var infoAreaBlack: UIColor {
        return UIColor(red: 39.0 / 255.0, green: 37.0 / 255.0, blue: 47.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var mainGreen: UIColor {
      return UIColor(red: 33.0 / 255.0, green: 205.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var customGray: UIColor {
        return UIColor(red: 99.0/255.0, green: 99.0/255.0, blue: 102.00/255.0, alpha: 1.0)
    }
    
    @nonobjc class var semiTransparentBlack: UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
    }
    
    @nonobjc class var lightSeaGreen: UIColor {
        return UIColor(red: 31.0/255.0, green: 41.0/255.0, blue: 45.0/255.0, alpha: 0.85)
    }
    
    @nonobjc class var transparent: UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0)
    }
    
    @nonobjc class var lightLayer: UIColor {
        return UIColor(red: 118.0/255.0, green: 118.0/255.0, blue: 128.00/255.0, alpha: 0.20)
    }

}
