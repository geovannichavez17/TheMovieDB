//
//  MovieDetailsViewModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import Foundation


class MovieDetailsViewModel {
    
    var movie: Observable<Movie> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    
    //let movie: Movie?
    let moviesService = MoviesService()
    var moviesDataSource: Observable<[Movie]> = Observable(nil)
    
    var coordinator: MoviesCoordinator?
    
    init(coordinator: MoviesCoordinator, movie: Movie) {
        self.movie.value = movie
        self.coordinator = coordinator
    }
    
    
    func retrieveMovieDetails() {
        if isLoading.value ?? true { return }
        guard let movie = self.movie.value else { return }

        isLoading.value = true
        moviesService.getMovieDetails(movieId: "\(movie.id)") { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("error al obtener detalles")
            }
        }
        
    }
    
    
}
