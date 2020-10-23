//
//  AnalyticsUtility.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit
import Firebase

enum AnalyticsEvent {
    enum Firebase: String {
        case filmContent = "Film_Content"
    }
}

class AnalyticsUtility: NSObject {
    class func filmContent(imdbID: String) {
        Analytics.logEvent(AnalyticsEvent.Firebase.filmContent.rawValue, parameters: ["imdbID": imdbID])
    }
}
