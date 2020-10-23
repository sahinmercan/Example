//
//  MainViewController+Keyboard.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

extension MainViewController {
    //MARK: - Keyboard Notifications and Handlers
    func addKeyboardNotifications() {
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShowHandler), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHideHandler), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowHandler(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        tableViewFilm.contentInset.bottom = keyboardSize.height
        tableViewFilm.scrollIndicatorInsets.bottom = keyboardSize.height
    }
    
    @objc func keyboardWillHideHandler(_ notification: Notification) {
        tableViewFilm.contentInset.bottom = 0
        tableViewFilm.scrollIndicatorInsets.bottom = 0
    }
}

extension MainViewController {
    func setupToolBar() {
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(clickedToCloseButtonOnPickerView))
        let searchButton = UIBarButtonItem(title: "Ara", style: .plain, target: self, action: #selector(clickedToSearchButtonOnPickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([closeButton, spaceButton, searchButton], animated: false)
        
        searchBar.inputAccessoryView = toolBar
        searchBar.inputAccessoryView = toolBar
    }
    
    @objc func clickedToSearchButtonOnPickerView() {
        searchBar.resignFirstResponder()
        searchFilm()
    }
    
    @objc func clickedToCloseButtonOnPickerView() {
        searchBar.resignFirstResponder()
    }
    
    func searchFilm() {
        if 3 < searchBar.text.stringValue.count && !serviceLoad {
            resetSearch()
            self.filmItems.removeAll()
            tableViewFilm.reloadData()
            getFilms(searchText: searchBar.text.stringValue)
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        searchFilm()
    }
}
