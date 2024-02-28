//
//  MoviesTasks.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//


import Alamofire

protocol MoviesServiceTasks {
    func getNowPlayingMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getPopularMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getTopRatedMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getUpcomingMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getMovies(completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getMovieDetails(movieId: String, completionHandler: @escaping (Result<MovieDetailsResponse, Error>) -> Void)
}

class MoviesService: BaseService<MoviesTarget>, MoviesServiceTasks {
    
    func getNowPlayingMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getNowPlaying(page: page), responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getPopularMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getPopular(page: page), responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getTopRatedMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getTopRated(page: page), responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getUpcomingMovies(page: Int, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getUpcoming(page: page), responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getMovies(completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getMovies, responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getMovieDetails(movieId: String, completionHandler: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        self.request(target: .getMovieDetails(movieId: movieId), responseClass: MovieDetailsResponse.self) { result in
            completionHandler(result)
        }
    }
}
