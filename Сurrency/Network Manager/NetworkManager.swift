//
//  NetworkManager.swift
//  Сurrency
//
//  Created by Алексей Евменьков on 11/3/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import Foundation
import CoreData

class NetworkManager {
    
    private init() {}
    static let shared = NetworkManager()
    
    private let apikey = "71f3bc8d41181084e31b"
    private let url = "https://free.currconv.com/api/v7/convert"
    
    func getCurrentCurrency(complition: @escaping (Response)->Void) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: "USD_BYN,BYN_USD"),
            URLQueryItem(name: "compact", value: "ultra"),
            URLQueryItem(name: "apiKey", value: "\(apikey)")
        ]
        let url = urlComponents?.url
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            guard let data = data else { return }
            guard let currency: Response = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Error can't parse")
                return
            }
            return complition(currency)
        }
        task.resume()
        
    }
    
}
