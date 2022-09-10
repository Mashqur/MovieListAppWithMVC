//
//  Movies.swift
//  MovieListApp
//
//  Created by Mashqur Habib Himel on 9/9/22.
//

import Foundation

struct Movie: Codable {
    let name: String
    let overview: String
    let poster_url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case overview
        case poster_url = "poster_path"
    }
}

struct MovieFeed: Codable {
    let page: Int
    let results: [Movie]
}
