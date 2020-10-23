//
//  API.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

struct API {

    static let tmdb = "https://api.themoviedb.org"
    static let base = tmdb + "/3/movie/popular"
    static let searchBase = tmdb + "/3/search/movie"
    static let filmItem = tmdb + "/3/movie/"
    static let photoBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let creditBase = tmdb + "/3/credit/"

    static let apiKey = "?api_key=bb54438b8d10ff99541b95a2360b0299"

    static let root = base + apiKey
    static let searchRoot = searchBase + apiKey
}

