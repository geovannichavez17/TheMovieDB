//
//  MovieDetailsRequests.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import Foundation

struct MovieDetailsResponse: Codable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videos: Videos
    let credits: Credits
    let similar: Similar
    let watchProviders: WatchProviders

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos
        case credits = "credits"
        case similar = "similar"
        case watchProviders = "watch/providers"
    }
}

 
// MARK: - Videos
struct Videos: Codable {
    let videos: [Video]?
    
    enum CodingKeys: String, CodingKey {
        case videos = "results"
    }
}

struct Video: Codable {
    let name, key: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name, key
        case size, type, official, id
    }
}



// MARK: - Credits
/*struct CreditItem: Codable {
    let credits: Credits?
}*/

struct Credits: Codable {
    let cast, crew: [Cast]?
    
    enum CodingKeys: String, CodingKey {
        case cast, crew
    }
}

struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, job
    }
}




// MARK: - Similar

struct Similar: Codable {
    let page: Int?
    let similarResults: [SimilarResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case similarResults = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SimilarResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



// MARK: - WatchProviders

struct WatchProvidersItem: Codable {
    let watchProviders: WatchProviders?

    enum CodingKeys: String, CodingKey {
        case watchProviders = "watch/providers"
    }
}

struct WatchProviders: Codable {
    let providerResults: ProvidersResults?
    
    enum CodingKeys: String, CodingKey {
        case providerResults = "results"
    }
}

struct ProvidersResults: Codable {
    let us: US?

    enum CodingKeys: String, CodingKey {
        case us = "US"
    }
}

struct WatchProvider: Codable {
    let logoPath: String?
    let providerID: Int?
    let providerName: String?
    let displayPriority: Int?

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}

struct US: Codable {
    let link: String?
    let flatrate, rent, buy, ads: [WatchProvider]?
}

