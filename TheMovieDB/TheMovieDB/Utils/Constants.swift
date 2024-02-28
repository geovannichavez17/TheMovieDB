//
//  Constants.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation

struct Constants {
    
    struct Common {
        static let acceptButton = "OK"
        static let cancelButton = "Cancel"
        static let continueButton = "Continue"
        static let loadingLabel = "Please wait…"
        static let titleError = "Ups!"
        static let labelError = "Something went wrong, please try again…"
    }
    
    struct APIs {
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let posterImageUrl = "https://image.tmdb.org/t/p/w500"
        static let profileImageUrl = "https://image.tmdb.org/t/p/w300"
        static let bannerImageUrl = "https://image.tmdb.org/t/p/w1280"
        
        static let movies = "/movie/now_playing"
        static let nowPlayingPaged = "movie/now_playing?page="
        static let popularPaged = "movie/popular?page="
        static let topRatedPaged = "movie/top_rated?page="
        static let upcomingPaged = "movie/upcoming?page="
        
        static let youTubeThumbnailUrl = "http://img.youtube.com/vi"
        static let youTubeApiKey = "AIzaSyAVgq_STlzDgmh2bi0IRCRNvuUh3yzIGag"
        static let youTubeAppLink = "youtube://www.youtube.com/watch?v="
        static let youTubeUrl =  "https://www.youtube.com/watch?v="
        static let thumbnailResolution = "sddefault.jpg"
        
        static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjY1MDU2YWVjNDcxOGMwOTIxNGQ0YTdlY2NkNTg4MCIsInN1YiI6IjYwMzA3OGFhN2Y2YzhkMDAzZjBmN2FlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m1iwx98S8xTSrFWbDFbL2rzqaIBvNOXjcyf1ycJ9ak8"
    }
    
    struct Formats {
        static let UTCTime = "yyyy-MM-dd HH:mm:ss 'UTC'"
        static let YYYY_MM_DD = "YYYY-MM-DD"
        static let MMM_dd__yyyy = "MMM dd, yyyy"
    }
}
