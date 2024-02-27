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
}

extension MoviesTarget: BaseTarget {
    var baseURL: String {
        switch self {
        default:
            return Constants.APIs.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .getRepos(let username):
            return "/users/\(username)/repos"
        case .getMovies:
            return Constants.APIs.movies
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRepos:
            return .get
        case .getMovies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getRepos:
            return .requestPlain
        case .getMovies:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
}
