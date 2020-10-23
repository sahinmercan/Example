//
//  SearchResponseItem.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import Foundation

class SearchResponseItem: BaseResponseItem {
    var results: [SearchResponseDataItem] = []
    var page = 0
    var total_pages = 0
    var total_results = 0
}
