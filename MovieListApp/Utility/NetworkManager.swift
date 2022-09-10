//
//  NetworkManager.swift
//  MovieListApp
//
//  Created by Mashqur Habib Himel on 9/9/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.allowsJSON5 = false
        return decoder
    }()
    
    func getMovieFeed() async throws -> [Movie] {
        let response = try await callAPI(for: .feed, withPayLoadType: MovieFeed.self)
        return response.results
        
    }
    
    private func callAPI<T: Decodable>(for endPoint: EndPoint, withPayLoadType payloadType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endPoint.asURLRequest)
        print("Data \(data) Response \(response)")
        let decoder = jsonDecoder
        let parsedResponse = try decoder.decode(T.self, from: data)
        return parsedResponse
    }
}
