//
//  PersonItem.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import Foundation

class PersonItem: BaseItem {
    var adult = 0
    var gender = 0
    var id = 0
    var known_for: [FilmResponseItem] = []
    var name = ""
    var profile_path = ""
    var profileUrl: String {
        get {
            return API.photoBaseUrl + profile_path
        }
    }
    var isPhoto: Bool {
        get {
            return profile_path.trimWhiteSpaceAndNewLines() != ""
        }
    }
}
