//
//  Network.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 04/04/21.
//

import Foundation

class Networking {
    
    
    func performRequest<T: Decodable>(type: T.Type,
                                      path: String,
                                      method: HTTPMethod,
                                      headers: [String: String] = [:],
                                      parameters: [String: Any]? = nil,
                                      completion: @escaping (T?, Error?) ->()) {
        guard let url = URL(string: path) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if let params = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                completion(nil, error)
                return
            }
        }
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
        
            
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async { completion(result, nil) }
                } catch let error {
                    DispatchQueue.main.async { completion(nil, error) }
                }
            }
        }
        task.resume()
    }
}
