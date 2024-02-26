//
//  UIView+Extensions.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import UIKit


extension UIView {
    
    func addTapGesture(selector: Selector?, target: AnyObject) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: target, action: selector)
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
}
