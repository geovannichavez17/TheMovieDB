//
//  MoviesTasks.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//


import Alamofire

protocol MoviesServiceTasks {
    func getMovies(completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
}

// 3
class MoviesService: BaseService<MoviesTarget>, MoviesServiceTasks {
    
    func getMovies(completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getMovies, responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
}
