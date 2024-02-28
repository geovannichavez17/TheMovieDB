//
//  Observable.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T?) -> Void)?
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    func bind(_ listener: @escaping((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
