//
//  PosterTableViewCell.swift
//  Example
//
//  Created by sahin on 23.10.2020.
//  Copyright © 2020 sahin. All rights reserved.
//

import UIKit

class PosterTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageTitleTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setup(url: String) {
        photoFill(url: url)
    }
    
    func photoFill(url: String) {
        if url != "" {
            if let imageURL = URL(string: url) {
                imageTitle.kf.setImage(with: imageURL, placeholder: UIImage(), options: [.transition(.fade(1))])
            }
        }
    }
}

extension PosterTableViewCell {
    //MARK: Notification Image Parallax
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if 0 < scrollView.contentOffset.y {
            // scrolling up
            containerView.clipsToBounds = true
            imageTitleTop.constant = 0
        } else {
            // scrolling down
            containerView.clipsToBounds = false
            imageTitleTop.constant = scrollView.contentOffset.y
        }
    }
}
