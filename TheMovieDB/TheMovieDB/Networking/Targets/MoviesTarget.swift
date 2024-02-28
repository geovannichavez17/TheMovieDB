//
//  MoviesTarget.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//

import Alamofire
import Foundation

enum MoviesTarget {
    case getRepos(username: String)
    case getMovies
    case getMovieDetails(movieId: String)
    case getTrailerThumbnail(movieId: String)
}

extension MoviesTarget: BaseTarget {
    var baseURL: String {
        switch self {
        case .getTrailerThumbnail:
            return Constants.APIs.youTubeThumbnailUrl
        default:
            return Constants.APIs.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .getRepos(let username):
            return "/users/\(username)/repos"
        case .getMovieDetails(let movieId):
            return "/movie/\(movieId)?append_to_response=videos,credits,similar,watch/providers"
        case .getMovies:
            return Constants.APIs.movies
        case .getTrailerThumbnail(let movieId):
            return "/\(movieId)/\(Constants.APIs.thumbnailResolution)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRepos:
            return .get
        case .getMovieDetails:
            return .get
        case .getMovies:
            return .get
        case .getTrailerThumbnail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getRepos:
            return .requestPlain
        case .getMovieDetails:
            return .requestPlain
        case .getMovies:
            return .requestPlain
        case .getTrailerThumbnail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovieDetails:
            return [String: String]()
        default:
            return [:]
        }
    }
    
}
