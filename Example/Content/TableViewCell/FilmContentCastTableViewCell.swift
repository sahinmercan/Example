//
//  FilmContentCastTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

protocol FilmContentCastTableViewCellDelegate: AnyObject {
    func clickedToCast()
}

class FilmContentCastTableViewCell: UITableViewCell {

    //MARK: - Variables
    weak var filmContentCastTableViewCellDelegate: FilmContentCastTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setup() {
    }
    
    @IBAction func clickedToCast(_ sender: UIButton) {
        filmContentCastTableViewCellDelegate?.clickedToCast()
    }
}
