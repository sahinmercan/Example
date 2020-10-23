//
//  FilmTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit
import SkeletonView

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var labelFilmTitle: UILabel!
    @IBOutlet weak var labelFilmYear: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setup(isSetup: Bool) {
        if isSetup {
            imagePoster.showAnimatedSkeleton()
            labelFilmTitle.showAnimatedSkeleton()
            labelFilmYear.showAnimatedSkeleton()
        } else {
            imagePoster.hideSkeleton()
            labelFilmTitle.hideSkeleton()
            labelFilmYear.hideSkeleton()
        }
    }
}
