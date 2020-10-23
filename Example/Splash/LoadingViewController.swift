//
//  LoadingViewController.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class LoadingViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var splashLabel: UILabel!
    
    //MARK: Variables
    var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.connectionCheck()
        }
    }
    
    //MARK: - Setup
    func setup() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func connectionCheck() {
        if isConnectedToInternet {
            let mainVC = ViewControllers.main
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
        } else {
            ErrorHelper.showAlert(message: "İnternet bağlantınızı kontrol edin", retryFunction: { self.connectionCheck() })
        }
    }
}

//MARK: - Firebase RemoteConfig
extension LoadingViewController {
    func loadDefaultValues() {
      let appDefaults = [
        "splashTitle" : "Başlık" as NSObject
      ]
      RemoteConfig.remoteConfig().setDefaults(appDefaults)
    }
    
    func fetchCloudValues() {
      let fetchDuration: TimeInterval = 0
      RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { status, error in

        if let error = error {
          entLog("HataŞ \(error)")
          return
        }
        
        entLog("İşlem balarıyla tamamlandı.")
        RemoteConfig.remoteConfig().activateFetched()
        self.updateValue()
      }
    }
    
    func updateValue() {
        let splashTitle = RemoteConfig.remoteConfig().configValue(forKey: "splashTitle").stringValue
        splashLabel.text = splashTitle
    }
}
