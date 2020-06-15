//
//  Request.swift
//  sukoapp
//
//  Created by macbook on 6/11/20.
//  Copyright © 2020 SmartCyberSolution. All rights reserved.
//

import Foundation

class Request{
    let baseUrl = "http://sukowidodo.com:8080"
    
    func httpRequest <T: Codable>(
            endpoint: String,
            parameters: [String: Any],
            completion: @escaping(T?, URLResponse?, Error?) -> Void
        ) {
        guard let url = URL(string : baseUrl+endpoint)else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, response, error)
                return
            }
            completion(try? self.newJSONDecoder().decode(T.self, from: data), response, nil)
            
            }.resume()
        
    }
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
    func loginPost(with path: String, parameters:[String : Any], completion: @escaping (ResponseLogin?, URLResponse?, Error?) -> Void) -> Void {
        httpRequest(endpoint: path, parameters: parameters, completion: completion)
    }
}
