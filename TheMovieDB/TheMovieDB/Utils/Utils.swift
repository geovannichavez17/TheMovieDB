//
//  Utils.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import Foundation

class Utils {
    
    static func changeDateFormat(fromDate: String?, _ inputFormat: String, _ outputFormat: String) -> String {
        
        // Gets date from string
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = inputFormat
        
        let inputDate = dateFormatter.date(from: fromDate ?? "")
        print("inputDate: \(inputDate as Any)")
        
        // Formats date as string
        dateFormatter.dateFormat = outputFormat
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let outputDateStr = dateFormatter.string(from: inputDate!)
        print("outputDate: \(outputDateStr)")
        
        return outputDateStr
    }
}
