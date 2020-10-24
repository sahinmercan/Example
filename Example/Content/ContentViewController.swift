//
//  ContentViewController.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit
import Alamofire

class ContentViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableViewFilm: UITableView!
    
    //MARK: Variables
    var filmItem = FilmResponseItem()
    var count = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        AnalyticsUtility.filmContent(imdbID: filmItem.id)
        setupXib()
    }
    
    func setupXib() {
        tableViewFilm.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableViewFilm.register(UINib(nibName: PosterTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PosterTableViewCell.reuseIdentifier)
        tableViewFilm.register(UINib(nibName: FilmContentTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FilmContentTableViewCell.reuseIdentifier)
        tableViewFilm.register(UINib(nibName: FilmContentUrlTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FilmContentUrlTableViewCell.reuseIdentifier)
        tableViewFilm.register(UINib(nibName: FilmContentCastTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FilmContentCastTableViewCell.reuseIdentifier)
        tableViewFilm.reloadData()
    }
}

//MARK: - UITableView Data Source
extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.reuseIdentifier, for: indexPath) as! PosterTableViewCell
            cell.setup(url: filmItem.backdropUrl, isPhoto: filmItem.isPhoto)
            
            return cell
        } else if indexPath.row == count - 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmContentUrlTableViewCell.reuseIdentifier, for: indexPath) as! FilmContentUrlTableViewCell
            cell.setup(filmItem: filmItem)
            
            return cell
        } else if indexPath.row == count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmContentCastTableViewCell.reuseIdentifier, for: indexPath) as! FilmContentCastTableViewCell
            cell.setup()
            cell.filmContentCastTableViewCellDelegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmContentTableViewCell.reuseIdentifier, for: indexPath) as! FilmContentTableViewCell
            cell.setup(filmItem: filmItem, index: indexPath.row - 1)
            
            return cell
        }
    }
}

//MARK: - UITableView Delegate
extension ContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let posterTitle = tableViewFilm.cellForRow(at: IndexPath(row: 0, section: 0)) as? PosterTableViewCell {
            posterTitle.scrollViewDidScroll(scrollView: scrollView)//Parallax
        }
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension ContentViewController: FilmContentCastTableViewCellDelegate {
    func clickedToCast() {
        castService()
    }
}

extension ContentViewController {
    func castToService(item: CreditResponseItem) {
        let personVC = ViewControllers.person
        personVC.creditItem = item
        personVC.count = item.person.known_for.count * 4 + 2
        navigationController?.pushViewController(personVC, animated: true)
    }
    
    func castService() {
        let creditId = filmItem.credits.cast.first?.credit_id ?? ""
        let url = API.creditBase + creditId + API.apiKey
        entLog("URL: \(url)")
        NavigationHelper.showLoadingIndicator()
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let item = CreditResponseItem(dictionary: value as! NSDictionary)
                if item.isSuccess {
                    NavigationHelper.hideLoadingIndicator {
                        self.castToService(item: item)
                    }
                } else {
                    NavigationHelper.hideLoadingIndicator {
                        ErrorHelper.showAlert(message: item.status_message)
                    }
                }
            case .failure(let error):
                NavigationHelper.hideLoadingIndicator {
                    ErrorHelper.showAlert(for: error, message: "Geçici süre hizmet veremiyoruz.", retryFunction: { self.castService() })
                }
            }
        }
    }
}
