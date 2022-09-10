//
//  EndPoint.swift
//  MovieListApp
//
//  Created by Mashqur Habib Himel on 9/9/22.
//

import Foundation

enum EndPoint {
    case feed
    
    var url: URL {
        switch self {
        case .feed:
            let urlString = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel"
            return URL(string: urlString)!
        }
    }
    
    var asURLRequest: URLRequest {
        switch self {
        case .feed:
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            return urlRequest
        }
    }
}
