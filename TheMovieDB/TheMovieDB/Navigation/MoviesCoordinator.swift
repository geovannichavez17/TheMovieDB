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
        let viewModel = MoviesViewModel(coordinator: self)
        homeVC.set(viewModel: viewModel)
        navigationController!.pushViewController(homeVC, animated: true)
    }
    
    func navigateToDetails(movie: Movie) {
        let movieDetailsVC = MovieDetailsVC()
        let viewModel = MovieDetailsViewModel(coordinator: self, movie: movie)
        movieDetailsVC.set(viewModel: viewModel)
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
