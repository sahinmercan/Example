//
//  ViewControllers.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

struct ViewControllers {
    static var loadingIndicator: LoadingIndicatorViewController {
        return Storyboards.loadingIndicator.instantiateViewController(withIdentifier: "LoadingIndicatorViewController") as! LoadingIndicatorViewController
    }
    static var main: UINavigationController {
        return Storyboards.main.instantiateViewController(withIdentifier: "MainNavigationViewController") as! UINavigationController
    }
    static var content: ContentViewController {
        return Storyboards.content.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
    }
    static var person: PersonContentViewController {
        return Storyboards.person.instantiateViewController(withIdentifier: "PersonContentViewController") as! PersonContentViewController
    }
}
