//
//  MoviesCoordinator.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import Foundation

class MoviesCoordinator: BaseCoordinator {
    func start(animated: Bool? = nil) {
        let homeVC = MoviesVC()
        //let presenter = HomePresenter(coordinator: self, view: homeVC)
        //homeVC.set(presenter: presenter)
        //homeVC.hideNavbar = true
        navigationController!.pushViewController(homeVC, animated: animated ?? true)
    }
}
