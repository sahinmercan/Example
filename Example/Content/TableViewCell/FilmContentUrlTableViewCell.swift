//
//  FilmContentUrlTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class FilmContentUrlTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    //MARK: - Variables
    var filmItem = FilmResponseItem()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setup(filmItem: FilmResponseItem) {
        self.filmItem = filmItem
        labelTitle.text = "Video"
        labelContent.text = "Fragmanı izlemek için tıklayınız."
    }
    
    @IBAction func clickedToVideo(_ sender: UIButton) {
        openYoutube(key: filmItem.videos.results.first?.key ?? "")
    }
}


extension FilmContentUrlTableViewCell {
    func openYoutube(key: String) {
        tryURL(urls: [
            "youtube://\(key)", // App
            "https://www.youtube.comZ/watch?v=\(key)" // Website if app fails
            ])
    }
}

extension FilmContentUrlTableViewCell {
    func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                if #available(iOS 10.0, *) {
                    application.open(URL(string: url)!)
                }
                return
            }
        }
    }
}

