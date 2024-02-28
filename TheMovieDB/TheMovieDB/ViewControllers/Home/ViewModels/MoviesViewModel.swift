//
//  MoviesViewModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import Foundation

class MoviesViewModel {
    
    private var nowPlayingPage = 1
    private var popularPage = 1
    private var topRatedPage = 1
    private var upcomingPage = 1
    
    private let moviesService: MoviesService?
    var coordinator: MoviesCoordinator?
    
    var moviesDataSource: Observable<[Movie]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var dataRetrieved: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable(nil)
    
    init(coordinator: MoviesCoordinator) {
        self.coordinator = coordinator
        self.moviesService = MoviesService()
    }
    
    func select(category: String) {
        guard let category = Categories(rawValue: category) else { return }
        retrieveMovies(from: category)
    }
    
    func retrieveMovies(from category: Categories) {
        if isLoading.value ?? true { return }
        isLoading.value = true
        
        
        switch category {
        case .nowPlaying:
            moviesService?.getNowPlayingMovies(page: nowPlayingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result)
            }
        case .popular:
            moviesService?.getPopularMovies(page: nowPlayingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result)
            }
        case .topRated:
            moviesService?.getTopRatedMovies(page: topRatedPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result)
            }
        case .upcoming:
            moviesService?.getUpcomingMovies(page: upcomingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result)
            }
        }
    }
    
    private func handleService(result: Result<MoviesReponse, Error>) {
        moviesDataSource.value = nil
        errorMessage.value = nil
        
        switch result {
        case .success(let response):
            moviesDataSource.value = response.movies
        case .failure:
            errorMessage.value = Constants.Common.labelError
        }
    }
}
