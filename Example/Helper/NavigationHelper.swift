//
//  NavigationHelper.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class NavigationHelper {
    
    //MARK: - Visible View Controller Finder Methods
    static func getVisibleContainerViewController(for rootViewController: UIViewController? = nil) -> UIViewController? {
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if let presentedVC = rootVC?.presentedViewController {
            return getVisibleContainerViewController(for: presentedVC)
        } else {
            return rootVC
        }
    }
    
    static func getVisibleViewController(for rootViewController: UIViewController? = nil) -> UIViewController? {
        if let presentedContainerViewController = getVisibleContainerViewController(for: rootViewController) {
            if let navigationController = presentedContainerViewController as? UINavigationController {
                return navigationController.viewControllers.last
            }
            
            if let tabBarController = presentedContainerViewController as? UITabBarController {
                if let selectedVC = tabBarController.selectedViewController {
                    if let selectedNavigationController = selectedVC as? UINavigationController {
                        return selectedNavigationController.viewControllers.last
                    } else {
                        return selectedVC
                    }
                }
            }
            
        }
        return rootViewController
    }
    
    //MARK: - Loading Indicator View Controller methods
    static func showLoadingIndicator() {
        let visibleContainerVC = getVisibleContainerViewController()
        let loadingIndicatorVC = ViewControllers.loadingIndicator
        loadingIndicatorVC.modalPresentationStyle = .overCurrentContext
        visibleContainerVC?.present(loadingIndicatorVC, animated: false, completion: nil)
    }
    
    static func hideLoadingIndicator(completion: (() -> Void)? = nil) {
        if let visibleVC = getVisibleContainerViewController(),
            let loadingIndicatorVC = visibleVC as? LoadingIndicatorViewController {
            loadingIndicatorVC.dismiss(animated: true) {
                if let completion = completion {
                    completion()
                }
            }
        }
    }
}
