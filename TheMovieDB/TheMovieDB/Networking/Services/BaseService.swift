//
//  BaseService.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//

import Alamofire
import Foundation

class BaseService<T: BaseTarget> {
    
    func request<M: Codable>(target: T, responseClass: M.Type, completionHandler:@escaping (Result<M, Error>)-> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseData { response in
            switch response.result {
                
            case .success(let result):
                if let code = response.response?.statusCode {
                    switch code {
                    case 200...299:
                        do {
                            completionHandler(.success(try JSONDecoder().decode(M.self, from: result)))
                        } catch let error {
                            print(String(data: result, encoding: .utf8) ?? "nothing received")
                            completionHandler(.failure(error))
                        }
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completionHandler(.failure(error))
                    }
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
        /*AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseJSON { (response) in
            // 6
            guard let statusCode = response.response?.statusCode else {
                print("StatusCode not found")
                completionHandler(.failure(NSError()))
                return
            }
            
            // 7
            if statusCode == 200 {
                
                // 8
                guard let jsonResponse = try? response.result.get() else {
                    print("jsonResponse error")
                    completionHandler(.failure(NSError()))
                    return
                }
                // 9
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    print("theJSONData error")
                    completionHandler(.failure(NSError()))
                    return
                }
                // 10
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    print("responseObj error")
                    completionHandler(.failure(NSError()))
                    return
                }
                completionHandler(.success(responseObj))
                
            } else {
                print("error statusCode is \(statusCode)")
                completionHandler(.failure(NSError()))
                
            }
            
        }*/
        
    }
    
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
