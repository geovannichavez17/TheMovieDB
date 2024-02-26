//
//  CoordinatorProtocol.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import Foundation

protocol CoordinatorProtocol {
    func addChildCoordinator(_ coordinator: CoordinatorProtocol)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
