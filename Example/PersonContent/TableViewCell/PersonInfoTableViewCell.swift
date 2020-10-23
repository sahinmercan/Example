//
//  PersonInfoTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelFilms: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setup(name: String) {
        labelTitle.text = name
        labelFilms.text = "Diğer Filmleri"
    }
}
