//
//  FilmContentTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class FilmContentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    let titleFilm: [String] = ["Film Adı", "Açıklama", "Oyuncular", "Ülke", "Tür", "Dil", "Vizyon Tarihi", "IMDB Puanı"]
    
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
}

func contentText(filmItem: FilmResponseItem, index: Int) -> String {
    switch index {
    case 0:
        return filmItem.original_title != "" ? filmItem.original_title : filmItem.original_name
    case 1:
        return filmItem.overview
    case 2:
        return getCast(cast: filmItem.credits.cast)
    case 3:
        return filmItem.production_countries.first?.name ?? ""
    case 4:
        return getGenres(genres: filmItem.genres)
    case 5:
        return filmItem.spoken_languages.first?.name ?? ""
    case 6:
        return filmItem.release_date
    case 7:
        return filmItem.vote_average
    default:
        return ""
    }
}

func getGenres(genres: [GenresItem]) -> String {
    var genreText = ""
    for (index, item) in genres.enumerated() {
        genreText = genreText + " - "  + item.name
        if index != genres.count - 1 {
            genreText = genreText + "\n"
        }
    }
    
    return genreText
}

func getCast(cast: [CastItem]) -> String {
    var castText = ""
    for (index, item) in cast.enumerated() {
        castText = castText + " - " + item.name
        if index != cast.count - 1 {
            castText = castText + "\n"
        }
    }
    
    return castText
}
