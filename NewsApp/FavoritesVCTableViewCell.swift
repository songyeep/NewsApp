//
//  FavoritesVCTableViewCell.swift
//  NewsApp
//
//  Created by Songyee Park on 5/3/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit

class FavoritesVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    var deleteButtonPressed: (() -> Void)?
    
    @IBAction func deleteFromFavorites(_ sender: AnyObject) {
        if let buttonPressed = deleteButtonPressed {
            buttonPressed()
        }
    }
    
}
