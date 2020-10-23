//
//  PersonFilmTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class PersonFilmTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    let titleFilm: [String] = ["Film Adı", "Açıklama", "Vizyon Tarihi", "IMDB Puanı"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setup(filmItem: FilmResponseItem, index: Int) {
        labelTitle.text = titleFilm[index]
        labelContent.text = contentText(filmItem: filmItem, index: index)
    }
    
    func contentText(filmItem: FilmResponseItem, index: Int) -> String {
        switch index {
        case 0:
            return filmItem.original_title != "" ? filmItem.original_title : filmItem.original_name
        case 1:
            return filmItem.overview
        case 2:
            return filmItem.release_date
        case 3:
            return filmItem.vote_average
        default:
            return ""
        }
    }
}
