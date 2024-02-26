//
//  Constants.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation

struct Constants {
    
    struct Common {
        static let btnAccept = "OK"
        static let btnCancel = "Cancel"
        static let btnContinue = "Continue"
        static let lblLoading = "Please wait…"
        static let titleError = "Ups!"
        static let lblNoInternetTitle = "No Internet Connection"
        static let lblNoInternet = "Check your internet connection"
        static let labelError = "Something went wrong, please try again…"
        static let lblServerErrorTitle = "Check your internet connection"
        static let lblServerError = "Unable to reach the servers, please try again…"
    }
    
    struct APIs {
        static let timeOutInterval = Double(16)
        static let apiUrl = "https://api.themoviedb.org/3/"
        static let posterUrl = "https://image.tmdb.org/t/p/w500"
        static let profileUrl = "https://image.tmdb.org/t/p/w300"
        static let backdropUrl = "https://image.tmdb.org/t/p/w1280"
        static let apiKey = "ab65056aec4718c09214d4a7eccd5880"
        
        static let auth_token = "\(apiUrl)/authentication/token/new?api_key=\(apiKey)"
        static let signin = "\(apiUrl)/authentication/token/validate_with_login?api_key=\(apiKey)"
        static let get_popular = "\(apiUrl)tv/popular?api_key=\(apiKey)"
        static let top_rated = "\(apiUrl)tv/top_rated?api_key=\(apiKey)"
        static let on_the_air = "\(apiUrl)tv/on_the_air?api_key=\(apiKey)"
        static let airing_today = "\(apiUrl)tv/airing_today?api_key=\(apiKey)"
        static let get_tv_show = "\(apiUrl)tv/"
        static let aggregate_credits = "/aggregate_credits?api_key=\(apiKey)"
        static let season_details = "\(apiUrl)tv/%1$@/season/%2$@?api_key=\(apiKey)"

    }
    
    struct Formats {
        static let UTCTime = "yyyy-MM-dd HH:mm:ss 'UTC'"
        static let YYYY_MM_DD = "YYYY-MM-DD"
        static let MMM_dd__yyyy = "MMM dd, yyyy"
    }
}
