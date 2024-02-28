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
    var currentFilter: Categories?
    
    var moviesDataSource: Observable<[Movie]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var dataRetrieved: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable(nil)
    
    init(coordinator: MoviesCoordinator) {
        self.coordinator = coordinator
        self.moviesService = MoviesService()
    }
    
    func retrieveMovies(from category: Categories) {
        if isLoading.value ?? true { return }
        isLoading.value = true
        
        if currentFilter != category {
            moviesDataSource.value = nil
        }
        currentFilter = category
        
        switch category {
        case .nowPlaying:
            moviesService?.getNowPlayingMovies(page: nowPlayingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                self.nowPlayingPage += 1
                handleService(result: result, category: category)
            }
        case .popular:
            moviesService?.getPopularMovies(page: nowPlayingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                self.popularPage += 1
                handleService(result: result, category: category)
            }
        case .topRated:
            moviesService?.getTopRatedMovies(page: topRatedPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                self.topRatedPage += 1
                handleService(result: result, category: category)
            }
        case .upcoming:
            moviesService?.getUpcomingMovies(page: upcomingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                self.upcomingPage += 1
                handleService(result: result, category: category)
            }
        }
    }
    
    private func handleService(result: Result<MoviesReponse, Error>, category: Categories) {
        errorMessage.value = nil
        /*if category != currentFilter {
            moviesDataSource.value = nil
        }*/
        
        switch result {
        case .success(let response):
            if moviesDataSource.value == nil {
                moviesDataSource.value = response.movies
            } else {
                guard let movies = response.movies else { return }
                moviesDataSource.value?.append(contentsOf: movies)
            }
        case .failure:
            errorMessage.value = Constants.Common.labelError
        }
    }
}
