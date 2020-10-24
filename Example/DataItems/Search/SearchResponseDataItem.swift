//
//  SearchResponseDataItem.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import Foundation

class SearchResponseDataItem: BaseItem {
    var adult: Int = 0
    var backdrop_path: String = ""
    var genre_ids: [Int] = []
    var id: String = ""
    var original_language: String = ""
    var original_title: String = ""
    var overview: String = ""
    var popularity: String = ""
    var poster_path: String = ""
    var release_date: String = ""
    var title: Int = 0
    var video: Int = 0
    var vote_average: Int = 0
    var vote_count: Int = 0
    var backdropUrl: String {
        get {
            return API.photoBaseUrl + backdrop_path
        }
    }
    var isPhoto: Bool {
        get {
            return backdrop_path.trimWhiteSpaceAndNewLines() != ""
        }
    }
    var posterUrl: String {
        get {
            return API.photoBaseUrl + poster_path
        }
    }
}
