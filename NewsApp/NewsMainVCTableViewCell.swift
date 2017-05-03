//
//  NewsMainVCTableViewCell.swift
//  NewsApp
//
//  Created by Songyee Park on 5/2/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import Foundation
import UIKit

class NewsMainVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    var favoritesButtonPressed: (() -> Void)?
    
    @IBAction func setAsFavorite(_ sender: AnyObject) {
        if let buttonPressed = favoritesButtonPressed {
            buttonPressed()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addToFavoritesButton.layer.borderColor = UIColor.blue.cgColor
        addToFavoritesButton.layer.borderWidth = 0.5
    }
    
}
