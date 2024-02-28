//
//  UIViewController+Extensions.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import UIKit

extension UIViewController {
    func isVisible() -> Bool {
        return self.isViewLoaded && self.view.window != nil
      }
}
