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
    
    private var nowPlayingPage = 1
    private var popularPage = 1
    private var topRatedPage = 1
    private var upcomingPage = 1
    
    //private let dependencies: Dependencies
    private let moviesService = MoviesService()
    var coordinator: MoviesCoordinator!
    
    var moviesDataSource: Observable<[Movie]> = Observable(nil)
    var nowPlayingDataSource: Observable<[Movie]> = Observable(nil)
    var popularDataSource: Observable<[Movie]> = Observable(nil)
    var topRatedDataSource: Observable<[Movie]> = Observable(nil)
    var upcomingDataSource: Observable<[Movie]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable(nil)
    
    init(coordinator: MoviesCoordinator) {
        self.coordinator = coordinator
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
            moviesService.getNowPlayingMovies(page: nowPlayingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result, category: category)
            }
        case .popular:
            moviesService.getPopularMovies(page: nowPlayingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result, category: category)
            }
        case .topRated:
            moviesService.getTopRatedMovies(page: topRatedPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result, category: category)
            }
        case .upcoming:
            moviesService.getUpcomingMovies(page: upcomingPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                handleService(result: result, category: category)
            }
        }
    }
    
    private func handleService(result: Result<MoviesReponse, Error>, category: Categories) {
        moviesDataSource.value = nil
        errorMessage.value = nil
        
        switch category {
        case .nowPlaying, .popular, .topRated, .upcoming:
            switch result {
            case .success(let response):
                moviesDataSource.value = response.movies
            case .failure:
                errorMessage.value = Constants.Common.labelError
            }
        /*case .popular:
            switch result {
            case .success(let response):
                moviesDataSource.value = response.movies
            case .failure:
                errorMessage.value = Constants.Common.labelError
            }
        case .topRated:
            switch result {
            case .success(let response):
                self.topRatedDataSource.value = response.movies
            case .failure:
                errorMessage.value = Constants.Common.labelError
            }
        case .upcoming:
            switch result {
            case .success(let response):
                self.upcomingDataSource.value = response.movies
            case .failure:
                errorMessage.value = Constants.Common.labelError
            }*/
        }
    }
    
    
    
    
    // FIXME: validar que el llamado no se vuelva a ejecutar cuando ya se haya hecho previamente
    /*func retrieveMovies() {
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
    }*/
    
    
}
