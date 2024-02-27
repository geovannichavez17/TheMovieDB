//
//  MoviesViewModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import Foundation

class MoviesViewModel {
    
    // MARK: - Typealiases
    //typealias Dependencies = HasMoviesService
    
    //private let dependencies: Dependencies
    private let moviesService = MoviesService()
    var coordinator: MoviesCoordinator!
    
    var moviesDataSource: Observable<[Movie]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    
    init(coordinator: MoviesCoordinator) {
        self.coordinator = coordinator
    }
    
    
    /*init(dependencies: Dependencies) {
        self.dependencies = dependencies
        moviesList = [Movie]()
    }*/
    
    func retrieveMovies() {
        if isLoading.value ?? true { return }
        
        isLoading.value = true
        moviesService.getMovies { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case .success(let response):
                self.moviesDataSource.value = response.movies
                
            case .failure(let failure):
                // FIXME: Add modal
                print("error al obtener movies")
            }
        }
    }
    
}
