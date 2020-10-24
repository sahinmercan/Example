//
//  PersonContentViewController.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class PersonContentViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableViewPerson: UITableView!
    
    //MARK: - Variables
    var creditItem = CreditResponseItem()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        setupXib()
    }
    
    func setupXib() {
        tableViewPerson.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableViewPerson.register(UINib(nibName: PosterTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PosterTableViewCell.reuseIdentifier)
        tableViewPerson.register(UINib(nibName: PersonInfoTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PersonInfoTableViewCell.reuseIdentifier)
        tableViewPerson.register(UINib(nibName: PersonFilmTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PersonFilmTableViewCell.reuseIdentifier)
        tableViewPerson.reloadData()
    }
}

//MARK: - UITableView Data Source
extension PersonContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditItem.person.known_for.count * 4 + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.reuseIdentifier, for: indexPath) as! PosterTableViewCell
            cell.setup(url: creditItem.person.profileUrl, isPhoto: creditItem.person.isPhoto)
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonInfoTableViewCell.reuseIdentifier, for: indexPath) as! PersonInfoTableViewCell
            cell.setup(name: creditItem.person.name)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonFilmTableViewCell.reuseIdentifier, for: indexPath) as! PersonFilmTableViewCell
            cell.setup(filmItem: getFilmItem(index: indexPath.row - 2), index: getFilmIndex(index: indexPath.row - 2))
            
            return cell
        }
    }
    
    func getFilmItem(index: Int) -> FilmResponseItem {
        let calculateIndex = index / 4
        return creditItem.person.known_for[calculateIndex]
    }
    
    func getFilmIndex(index: Int) -> Int {
        let calculateIndex = index % 4
        return calculateIndex
    }
}

//MARK: - UITableView Delegate
extension PersonContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        }
        return UITableView.automaticDimension
    }
}

extension PersonContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let posterTitle = tableViewPerson.cellForRow(at: IndexPath(row: 0, section: 0)) as? PosterTableViewCell {
            posterTitle.scrollViewDidScroll(scrollView: scrollView)//Parallax
        }
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

