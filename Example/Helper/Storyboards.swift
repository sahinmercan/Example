//
//  Storyboards.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

struct Storyboards {
    static var loadingIndicator: UIStoryboard {
        return UIStoryboard(name: "LoadingIndicator", bundle: nil)
    }
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    static var content: UIStoryboard {
        return UIStoryboard(name: "Content", bundle: nil)
    }
    static var person: UIStoryboard {
        return UIStoryboard(name: "PersonContent", bundle: nil)
    }
}
