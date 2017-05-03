//
//  FavoritesVCTableView.swift
//  NewsApp
//
//  Created by Songyee Park on 5/3/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit
import RealmSwift

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favoritesTableCell", for: indexPath) as! FavoritesVCTableViewCell
        configureFavoritesCell(cell, favorites[indexPath.row])
        return cell
    }
    
    func configureFavoritesCell(_ cell: FavoritesVCTableViewCell, _ favoriteArticle: FavoriteArticle) {
        cell.title.text = favoriteArticle.title
        cell.deleteButtonPressed = {
            self.deleteFromFavorites(favoriteArticle)
        }
    }
    
    func deleteFromFavorites(_ favoriteArticle: FavoriteArticle) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(favoriteArticle)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticleUrl = favorites[indexPath.row].url
        performSegue(withIdentifier: "toFavoriteNewsDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFavoriteNewsDetails" {
            let destination = segue.destination as! NewsDetailsVC
            destination.urlString = selectedArticleUrl
        }
    }
    
}
