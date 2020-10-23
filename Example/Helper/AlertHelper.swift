//
//  AlertHelper.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class AlertHelper {
    static func showUIAlert(withTitle title: String, message: String, isConfirmationAlert: Bool = true, actions: [UIAlertAction] = []) {
        let dismissButtonTitle = isConfirmationAlert ? NSLocalizedString("İptal'", comment: "") : NSLocalizedString("Tamam", comment: "")
        let uiAlert = getUIAlert(with: title, message: message, dismissButtonTitle: dismissButtonTitle, actions: actions)
        let visibleVC = NavigationHelper.getVisibleContainerViewController()
        visibleVC?.present(uiAlert, animated: true, completion: nil)
    }
    
    fileprivate static func getUIAlert(with title: String, message: String, dismissButtonTitle: String, actions: [UIAlertAction] = []) -> UIAlertController {
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissButtonTitle, style: .cancel)
        uiAlert.addAction(dismissAction)
        
        for action in actions {
            uiAlert.addAction(action)
        }
        
        return uiAlert
    }
}
