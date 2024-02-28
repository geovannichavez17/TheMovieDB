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
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let posterImageUrl = "https://image.tmdb.org/t/p/w500"
        static let profileImageUrl = "https://image.tmdb.org/t/p/w300"
        static let bannerImageUrl = "https://image.tmdb.org/t/p/w1280"
       // static let apiKey = "ab65056aec4718c09214d4a7eccd5880"
        static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjY1MDU2YWVjNDcxOGMwOTIxNGQ0YTdlY2NkNTg4MCIsInN1YiI6IjYwMzA3OGFhN2Y2YzhkMDAzZjBmN2FlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m1iwx98S8xTSrFWbDFbL2rzqaIBvNOXjcyf1ycJ9ak8"
        
        static let movies = "/movie/now_playing"
        static let moviesPaged = "/movie/now_playing?page=1"
        static let youTubeThumbnailUrl = "http://img.youtube.com/vi"
        static let thumbnailResolution = "sddefault.jpg"
        static let youTubeApiKey = "AIzaSyAVgq_STlzDgmh2bi0IRCRNvuUh3yzIGag"
        static let youTubeAppLink = "youtube://www.youtube.com/watch?v="
        static let youTubeUrl =  "https://www.youtube.com/watch?v="
        
        /*static let auth_token = "\(baseUrl)/authentication/token/new?api_key=\(apiKey)"
        static let signin = "\(baseUrl)/authentication/token/validate_with_login?api_key=\(apiKey)"
        static let get_popular = "\(baseUrl)tv/popular?api_key=\(apiKey)"
        static let top_rated = "\(baseUrl)tv/top_rated?api_key=\(apiKey)"
        static let on_the_air = "\(baseUrl)tv/on_the_air?api_key=\(apiKey)"
        static let airing_today = "\(baseUrl)tv/airing_today?api_key=\(apiKey)"
        static let get_tv_show = "\(baseUrl)tv/"
        static let aggregate_credits = "/aggregate_credits?api_key=\(apiKey)"
        static let season_details = "\(baseUrl)tv/%1$@/season/%2$@?api_key=\(apiKey)"*/

    }
    
    struct Formats {
        static let UTCTime = "yyyy-MM-dd HH:mm:ss 'UTC'"
        static let YYYY_MM_DD = "YYYY-MM-DD"
        static let MMM_dd__yyyy = "MMM dd, yyyy"
    }
}
