//
//  MoviesTarget.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//

import Alamofire
import Foundation

enum MoviesTarget {
    case getMovies
    case getNowPlaying(page: Int)
    case getPopular(page: Int)
    case getTopRated(page: Int)
    case getUpcoming(page: Int)
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
        case .getNowPlaying(let page):
            return "\(Constants.APIs.nowPlayingPaged)\(String(page))"
        case .getPopular(let page):
            return "\(Constants.APIs.popularPaged)\(String(page))"
        case .getTopRated(let page):
            return "\(Constants.APIs.topRatedPaged)\(String(page))"
        case .getUpcoming(let page):
            return "\(Constants.APIs.upcomingPaged)\(String(page))"
        case .getMovieDetails(let movieId):
            return "movie/\(movieId)\(Constants.APIs.movieDetails)"
        case .getMovies:
            return Constants.APIs.movies
        case .getTrailerThumbnail(let movieId):
            return "/\(movieId)/\(Constants.APIs.thumbnailResolution)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies,
             .getNowPlaying,
             .getPopular,
             .getTopRated,
             .getUpcoming,
             .getMovieDetails:
            return .get
        case .getTrailerThumbnail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies,
             .getNowPlaying,
             .getPopular,
             .getTopRated,
             .getUpcoming,
             .getMovieDetails:
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
