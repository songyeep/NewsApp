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
    
    var favoritesButtonPressed: (() -> Void)?
    
    @IBAction func setAsFavorite(_ sender: AnyObject) {
        if let buttonPressed = favoritesButtonPressed {
            buttonPressed()
        }
    }
    
}
