//
//  TargetType.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//

import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol BaseTarget {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var task: Task {get}
    //var headers: [String: String]? {get}
}

extension BaseTarget {
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(Constants.APIs.token)"
        return headers
    }
}
