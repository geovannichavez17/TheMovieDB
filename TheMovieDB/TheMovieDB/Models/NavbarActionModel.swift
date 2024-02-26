//
//  NavbarActionModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation


struct NavbarActionModel {
    var iconName: String?
    var action: Selector?
    
    init(iconName: String? = nil, action: Selector? = nil) {
        self.action = action
        self.iconName = iconName
    }
}
