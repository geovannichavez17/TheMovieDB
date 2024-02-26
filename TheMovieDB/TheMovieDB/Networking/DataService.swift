//
//  DataService.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation
import Combine

enum DataError: Error {
    case urlError(URLError?)
    case invalidData
    case encodingError
    case decodingError
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}


class DataService {
    
    static let main = DataService()
    
    private init(){}
    
    func retrieve<T: Codable>(url: String, cache: Bool) -> AnyPublisher<T, DataError> {
        
        return self.retrieveData(url: url, cache: cache).decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in .decodingError }
            .eraseToAnyPublisher()
    }
    
    func send<T: Codable, E: Codable>(object: E, cache: Bool, url: String, method: Method) -> AnyPublisher<T, DataError> {
        
        return Just(object)
            .encode(encoder: JSONEncoder())
            .mapError { error -> DataError in
                return .encodingError
            }
            .map { data -> URLRequest in
                var urlRequest = URLRequest(url: URL(string: url)!)
                urlRequest.httpMethod = "\(method)"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                urlRequest.timeoutInterval = Constants.APIs.timeOutInterval
                if cache {
                    urlRequest.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
                }
                return urlRequest
            }.flatMap {
                URLSession.shared.dataTaskPublisher(for: $0)
                    .mapError { error -> DataError in
                        return DataError.invalidData
                    }
                    .map{ $0.data }
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error -> DataError in
                        return .decodingError
                    }
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate func retrieveData(url: String, cache: Bool) -> AnyPublisher<Data, DataError> {
        
        guard let url = URL(string: url) else {
            return Fail<Data, DataError>(error: .urlError(URLError(URLError.Code.badURL))).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = Constants.APIs.timeOutInterval
        if cache {
            request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { result in
                print(result.data.asJson())
                return result.data
            }
            .mapError { error in .urlError(error) }
            .eraseToAnyPublisher()
    }
    
}

