//
//  FilmResponseItem.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import Foundation

class FilmResponseItem: BaseResponseItem {
    var adult = 0
    var backdrop_path = ""
    var belongs_to_collection = ""
    var budget = 0
    var homepage = ""
    var id = ""
    var imdb_id = ""
    var original_language = ""
    var original_title = ""
    var original_name = ""
    var overview = ""
    var popularity = ""
    var poster_path = ""
    var release_date = ""
    var revenue = 0
    var runtime = 0
    var tagline = ""
    var title = ""
    var vote_average = ""
    var vote_count = ""
    var genres: [GenresItem] = []
    var production_countries: [ProductionCountries] = []
    var spoken_languages: [SpokenLanguages] = []
    var videos = VideosItem()
    var credits = CreditsItem()
    var backdropUrl: String {
        get {
            return API.photoBaseUrl + backdrop_path
        }
    }
    var posterUrl: String {
        get {
            return API.photoBaseUrl + poster_path
        }
    }
}
