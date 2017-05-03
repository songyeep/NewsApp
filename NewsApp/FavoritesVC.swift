//
//  FavoritesVC.swift
//  NewsApp
//
//  Created by Songyee Park on 5/3/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var favoritesTable: UITableView!
    var favorites = [FavoriteArticle]()
    var selectedArticleUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
    }
    
    func getFavorites() {
        let favorites = try! Realm().objects(FavoriteArticle.self)
        for favorite in favorites {
            self.favorites.append(favorite)
        }
        favoritesTable.reloadData()
    }
    
}
