//
//  MovieDetailsViewModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import Foundation


class MovieDetailsViewModel {
    
    var movie: Observable<Movie> = Observable(nil)
    var videos: Observable<Videos> = Observable(nil)
    var crew: Observable<[Cast]> = Observable(nil)
    var similar: Observable<Similar> = Observable(nil)
    var watchProviders: Observable<WatchProviders> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    
    let moviesService: MoviesService?
    let coordinator: MoviesCoordinator?
    
    init(coordinator: MoviesCoordinator, movie: Movie) {
        self.movie.value = movie
        self.coordinator = coordinator
        moviesService = MoviesService()
    }
    
    
    func retrieveMovieDetails() {
        if isLoading.value ?? true { return }
        guard let movie = self.movie.value else { return }

        isLoading.value = true
        moviesService?.getMovieDetails(movieId: "\(movie.id)") { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case .success(let response):
                print(response)
                self.videos.value = response.videos
                self.crew.value = response.credits.cast
                self.similar.value = response.similar
                self.watchProviders.value = response.watchProviders
            case .failure(let failure):
                print("error al obtener detalles")
            }
        }
        
    }
    
    
}
