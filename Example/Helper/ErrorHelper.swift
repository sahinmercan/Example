//
//  ErrorHelper.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class ErrorHelper {
    
    static func showAlert(for error: Error? = nil, message: String = "", retryFunction: (() -> Void)? = nil, actions: [UIAlertAction] = []) {
        var errorCode = 0
        if let error = error {
            errorCode = (error as NSError).code
        }
        showAlert(for: errorCode, message: message, retryFunction: retryFunction, actions: actions)
    }
    
    static func showAlert(for errorCode: Int, message: String = "", retryFunction: (() -> Void)? = nil, actions: [UIAlertAction] = []) {
        guard let uiAlert = getUIAlert(for: errorCode, message: message, retryFunction: retryFunction, actions: actions) else {
            return
        }
        let visibleViewController = NavigationHelper.getVisibleContainerViewController()
        visibleViewController?.present(uiAlert, animated: true, completion: nil)
    }
    
    fileprivate static func getUIAlert(for errorCode: Int, message: String, retryFunction: (() -> Void)?, actions: [UIAlertAction]) -> UIAlertController? {
        let title = "Hata"
        var message = message
        switch errorCode {
        case -1001:
            message = "Bağlantı zaman aşımına uğradı."
        case -1009:
            message = "Lütfen internet bağlantınızı kontrol edin."
        case -1004:
            message = "Üzgünüz, ancak sunucularımız ile bağlantı kuramadık."
        case 500, 501:
            message = "Bilinmeyen bir hata oluştu"
        case 600, 700, 701: break
        default:
            break
        }
        
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Tamam", style: .cancel)
        uiAlert.addAction(dismissAction)
        
        if let retryFunction = retryFunction {
            let retryAction = UIAlertAction(title: "Tekrar Dene", style: .default, handler: { (action) in
                retryFunction()
            })
            uiAlert.addAction(retryAction)
        }
        
        for action in actions {
            uiAlert.addAction(action)
        }
        
        return uiAlert
    }
}
