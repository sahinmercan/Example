//
//  MainViewController.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class MainViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewFilm: UITableView!
    
    //MARK: Variables
    let notificationCenter = NotificationCenter.default
    var toolBar = UIToolbar()
    var filmItems: [SearchResponseDataItem] = []
    var oldFilmListCount = 0
    let requestLimit = 20
    var nextPageNumber = 1
    var tableViewEnd = false
    var requestedNextData = false
    var refreshControl: UIRefreshControl!
    var serviceLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        setupXib()
        setupPullToRefresh()
        addKeyboardNotifications()
        setupToolBar()
        getFilms()
    }
    
    func setupXib() {
        tableViewFilm.alwaysBounceVertical = false
        tableViewFilm.register(UINib(nibName: EmptyTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EmptyTableViewCell.reuseIdentifier)
        tableViewFilm.register(UINib(nibName: FilmTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FilmTableViewCell.reuseIdentifier)
        tableViewFilm.reloadData()
    }
    
    //MARK: - Pull To Refresh
    func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        tableViewFilm.addSubview(self.refreshControl)
    }
    
    @objc func handlePullToRefresh(_ refreshControl: UIRefreshControl) {
        if !serviceLoad {
            resetSearch()
            getFilms()
        }
    }
    
    func resetSearch() {
        serviceLoad = true
        nextPageNumber = 1
        tableViewEnd = false
    }
}

//MARK: - UITableView Data Source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmItems.count == 0 ? 1 : filmItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewEnd && filmItems.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier, for: indexPath) as! EmptyTableViewCell
            cell.labelTitle.text = "Aradığınız Kelime ile film bulunamadı."
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.reuseIdentifier, for: indexPath) as! FilmTableViewCell
            cell.setup(isSetup: filmItems.count == 0)
            if filmItems.count != 0 {
                cell.labelFilmTitle.text = filmItems[indexPath.row].original_title
                cell.labelFilmYear.text = "\(filmItems[indexPath.row].release_date)"
                photoFill(url: filmItems[indexPath.row].backdropUrl, cell: cell)
            }
            
            return cell
        }
    }
    
    func photoFill(url: String, cell: FilmTableViewCell) {
        if url != "" {
            if let imageURL = URL(string: url) {
                cell.imagePoster.kf.setImage(with: imageURL, placeholder: UIImage(), options: [.transition(.fade(1))])
            }
        }
    }
}

//MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < filmItems.count {
            getFilmItem(imdbID: filmItems[indexPath.row].id)
        }
    }
}


extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableViewFilm {
            controlVisibleCellIndexForNextArticleRequest()
        }
    }
    
    func controlVisibleCellIndexForNextArticleRequest() {
        if !requestedNextData && !tableViewEnd {
            for cell in tableViewFilm.visibleCells {
                if let indexPath = tableViewFilm.indexPath(for: cell) {
                    if indexPath.row >= tableViewFilm.numberOfRows(inSection: 0) - (requestLimit / 2) && 10 <= filmItems.count {
                        requestedNextData = true
                        nextPageNumber = nextPageNumber + 1
                        searchBarControl()
                        break
                    }
                }
            }
        }
    }
}

//MARK: TableView Data Source
extension MainViewController {
    func updateTableView() {
        let startingCellCount = nextPageNumber == 1 ? 1 : oldFilmListCount
        oldFilmListCount = filmItems.count
        let finalCellCount = oldFilmListCount
        var newIndexPaths: [IndexPath] = []
        let difference = finalCellCount - startingCellCount
        if difference > 0 {
            for i in 0..<difference {
                newIndexPaths.append(IndexPath(row: startingCellCount + i, section: 0))
            }
        }
        
        tableViewFilm.beginUpdates()
        if nextPageNumber == 1 {
            tableViewFilm.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
        tableViewFilm.insertRows(at: newIndexPaths, with: .fade)
        tableViewFilm.endUpdates()
        self.requestedNextData = false
    }
}

extension MainViewController {
    func getToFilmService(filmItems: [SearchResponseDataItem]) {
        if nextPageNumber == 1 && filmItems.count == 0 {
            tableViewEnd = true
            tableViewFilm.reloadData()
            refreshControl.endRefreshing()
        } else {
            if refreshControl.isRefreshing {
                self.filmItems = filmItems
                tableViewEnd = self.filmItems.count != requestLimit
                requestedNextData = false
                oldFilmListCount = self.filmItems.count
                tableViewFilm.reloadData()
                refreshControl.endRefreshing()
            } else if filmItems.count == requestLimit {
                self.filmItems.append(contentsOf: filmItems)
                updateTableView()
            } else {
                tableViewEnd = true
                self.filmItems.append(contentsOf: filmItems)
                updateTableView()
            }
        }
    }
    
    func searchBarControl() {
        if searchBar.text.stringValue == "" {
            getFilms()
        } else {
            getFilms(searchText: searchBar.text.stringValue)
        }
    }
    
    func getFilms(searchText: String? = nil) {
        var url = ""
        
        if let searchText = searchText {
            url = API.searchRoot + "&page=\(nextPageNumber)&query=\(searchText)"
        } else {
            url = API.root + "&page=\(nextPageNumber)"
        }
        
        entLog("URL: \(url)")
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let item = SearchResponseItem(dictionary: value as! NSDictionary)
                if item.isSuccess {
                    self.serviceLoad = false
                    self.getToFilmService(filmItems: item.results)
                } else {
                    self.serviceLoad = false
                    self.refreshControl.endRefreshing()
                    self.tableViewEnd = true
                    self.tableViewFilm.reloadData()
                    ErrorHelper.showAlert(message: item.status_message)
                }
            case .failure(let error):
                self.serviceLoad = false
                self.refreshControl.endRefreshing()
                self.tableViewEnd = true
                self.tableViewFilm.reloadData()
                ErrorHelper.showAlert(for: error, retryFunction: { self.getFilms(searchText: searchText) })
            }
        }
    }
}

extension MainViewController {
    func goToFilmContent(film: FilmResponseItem) {
        let contentVC = ViewControllers.content
        contentVC.filmItem = film
        navigationController?.pushViewController(contentVC, animated: true)
    }
    
    func getFilmItem(imdbID: String) {
        let url = API.filmItem + imdbID + API.apiKey + "&append_to_response=videos,credits"
        entLog("URL: \(url)")
        NavigationHelper.showLoadingIndicator()
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let item = FilmResponseItem(dictionary: value as! NSDictionary)
                if item.isSuccess {
                    NavigationHelper.hideLoadingIndicator {
                        self.goToFilmContent(film: item)
                    }
                } else {
                    NavigationHelper.hideLoadingIndicator {
                        ErrorHelper.showAlert(message: item.status_message)
                    }
                }
            case .failure(let error):
                NavigationHelper.hideLoadingIndicator {
                    ErrorHelper.showAlert(for: error, retryFunction: { self.getFilmItem(imdbID: imdbID) })
                }
            }
        }
    }
}
