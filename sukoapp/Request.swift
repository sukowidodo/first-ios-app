//
//  Request.swift
//  sukoapp
//
//  Created by macbook on 6/11/20.
//  Copyright © 2020 SmartCyberSolution. All rights reserved.
//

import Foundation


enum MyResult<T, E:Error>{
    case success(T)
    case failed(E)
}

class Request{
    let baseUrl = "http://sukowidodo.com:8080/users"
    func httpRequest(
            endpoint:String,
            parameters: [String: Any],
            completion:@escaping(MyResult<ResponseLogin, Error>) -> Void
        ) {
        guard let url = URL(string:baseUrl+endpoint)else{
            completion(.failed(NetworkingError.badUrl))
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
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let people = try decoder.decode(ResponseLogin.self, from: data)
                    completion(.success(people))
                } catch {
                    completion(.failed(error))
                }
            }
            }.resume()
        
    }
}

enum NetworkingError: Error{
    case badUrl
}
