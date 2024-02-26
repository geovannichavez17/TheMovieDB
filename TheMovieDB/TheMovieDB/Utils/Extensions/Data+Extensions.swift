//
//  Data+Extensions.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation

extension Data {
    
    func asJson() -> String {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            return JSONString
        }
        else {
            return "-"
        }
    }
}
