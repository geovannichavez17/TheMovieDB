//
//  MovieDetailsViewModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import Foundation
import GoogleAPIClientForREST_YouTube
import GTMSessionFetcherCore

class MovieDetailsViewModel {
    
    var movie: Observable<Movie> = Observable(nil)
    //var videos: Observable<Videos> = Observable(nil)
    var crew: Observable<[Cast]> = Observable(nil)
    var similarFilms: Observable<[SimilarResult]> = Observable(nil)
    var streamingProvider: Observable<[WatchProvider]> = Observable(nil)
    var rentProvider: Observable<[WatchProvider]> = Observable(nil)
    var buyProvider: Observable<[WatchProvider]> = Observable(nil)
    var videoItems: Observable<[VideoThumbnail]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    
    let moviesService: MoviesService?
    let coordinator: MoviesCoordinator?
    let service: GTLRYouTubeService?
    
    init(coordinator: MoviesCoordinator, movie: Movie) {
        self.movie.value = movie
        self.coordinator = coordinator
        moviesService = MoviesService()
        service = GTLRYouTubeService()
        service?.apiKey = Constants.APIs.youTubeApiKey
    }
    
    
    func retrieveMovieDetails() {
        if isLoading.value ?? true { return }
        guard let movie = self.movie.value else { return }

        isLoading.value = true
        moviesService?.getMovieDetails(movieId: "\(movie.id)") { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case .success(let response):
                print(response)
                //self.videos.value = response.videos
                self.crew.value = response.credits.cast
                self.similarFilms.value = response.similar.similarResults
                self.streamingProvider.value = response.watchProviders.providerResults?.us?.flatrate
                self.rentProvider.value = response.watchProviders.providerResults?.us?.rent
                self.buyProvider.value = response.watchProviders.providerResults?.us?.buy
                
               
                guard let videos = response.videos.videos else { return }
                let trailers = videos.filter { $0.type == "Trailer" }
                let videoKeys = trailers.compactMap{ $0.key }
                
                searchVideos(videoIds: videoKeys)
                
                        
            case .failure(let failure):
                print("error al obtener detalles")
            }
        }
    }
    
    private func searchVideos(videoIds: [String]) {
        var thumbnailsUrls = [VideoThumbnail]()
        
        let query = GTLRYouTubeQuery_VideosList.query(withPart: ["snippet"])
        query.identifier = videoIds
        
        service?.executeQuery(query, completionHandler: { ticket, result, errorResponse in
            if let error = errorResponse {
                print("Error al realizar la búsqueda: \(error.localizedDescription)")
                return
            }
            
            guard let response = result as? GTLRYouTube_VideoListResponse,
                  let videoItems = response.items,
                  !videoItems.isEmpty  else {
                return
            }
            
            for item in videoItems {
                guard let snippet = item.snippet,
                      let title = snippet.title else {
                    print("Error...")
                    return
                }
                
                guard let thumbnails = snippet.thumbnails,
                      let thumbnailDefault = thumbnails.standard else {
                    print("Error on getting thumbnails and thumbnailDefault")
                    return
                }
                
                guard let  thumbnailUrl = thumbnailDefault.url else {
                    print("Error on getting thumbnailUrl")
                    return
                }
                
                var newVideo = VideoThumbnail(title: title, thumbnailUrl: thumbnailUrl)
                thumbnailsUrls.append(newVideo)
                
                /*if let snippet = item.snippet, let title = snippet.title {
                    print("Video encontrado: \(title)")
                    if let thumbnails = snippet.thumbnails, let thumbnailDefault = thumbnails.standard {
                        // Obtén la URL de la miniatura
                        if let thumbnailUrl = thumbnailDefault.url {
                            // Aquí puedes usar la URL para cargar la imagen o realizar cualquier otra operación
                            print("URL de la miniatura: \(thumbnailUrl)")
                        }
                    }
                }*/
            }
            
            self.videoItems.value = thumbnailsUrls
        })
        
        
    }
}
