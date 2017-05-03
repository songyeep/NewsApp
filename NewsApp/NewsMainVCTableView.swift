//
//  NewsMainVCTableView.swift
//  NewsApp
//
//  Created by Songyee Park on 5/2/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

extension NewsMainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showFavoritesOnly {
            return favorites.count
        } else {
            return articles.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsList.dequeueReusableCell(withIdentifier: "articleTableCell", for: indexPath) as! NewsMainVCTableViewCell
        if showFavoritesOnly {
            configureFavoriteTableCell(cell, favorites[indexPath.row])
        } else {
            configureNewsTableCell(cell, articles[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showFavoritesOnly {
            selectedArticleUrl = favorites[indexPath.row].url
        } else {
            selectedArticleUrl = articles[indexPath.row].url
        }
        performSegue(withIdentifier: "toNewsDetails", sender: self)
    }
    
    func configureNewsTableCell(_ cell: NewsMainVCTableViewCell, _ article: Article) {
        cell.title.text = article.title
        if let urlToImage = URL(string: article.urlToImage) {
            cell.thumbnailImage.sd_setImage(with: urlToImage, placeholderImage: UIImage())
        }
        cell.date.text = article.publishedAt
        cell.author.text = "By " + article.author
        cell.addToFavoritesButton.setTitle("Add to Favorites", for: .normal)
        cell.addToFavoritesButton.setTitleColor(UIColor.blue, for: .normal)
        cell.favoritesButtonPressed = {
            self.savedAsFavorite(article)
        }
        for favorite in favorites {
            if article.url == favorite.url {
                cell.addToFavoritesButton.setTitle("Remove from Favorites", for: .normal)
                cell.addToFavoritesButton.setTitleColor(UIColor.red, for: .normal)
                cell.favoritesButtonPressed = {
                    self.deleteFromFavorites(favorite)
                }
            }
        }
    }
    
    func configureFavoriteTableCell(_ cell: NewsMainVCTableViewCell, _ favorite: FavoriteArticle) {
        cell.title.text = favorite.title
        cell.date.text = favorite.publishedAt
        cell.author.text = "By " + favorite.author
        if let urlToImage = URL(string: favorite.urlToImage) {
            cell.thumbnailImage.sd_setImage(with: urlToImage, placeholderImage: UIImage())
        }
        cell.addToFavoritesButton.setTitle("Remove from Favorites", for: .normal)
        cell.addToFavoritesButton.setTitleColor(UIColor.red, for: .normal)
        cell.favoritesButtonPressed = {
            self.deleteFromFavorites(favorite)
        }
    }
    
    func savedAsFavorite(_ article: Article) {
        let favoriteArticle = FavoriteArticle()
        favoriteArticle.title = article.title
        favoriteArticle.url = article.url
        favoriteArticle.articleDescription = article.description
        favoriteArticle.urlToImage = article.urlToImage
        favoriteArticle.publishedAt = article.publishedAt
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(favoriteArticle)
        }
        
//        let successAlert = AlertHelper.showSuccess("Added article to Favorites")
//        self.present(successAlert, animated: true) { 
//            self.newsList.reloadData()
//        }
        
        let alertVC = UIAlertController(title: "Success", message: "Added article to Favorites", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.getFavorites()
        }
        alertVC.addAction(ok)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func deleteFromFavorites(_ favoriteArticle: FavoriteArticle) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(favoriteArticle)
        }
    
        let alertVC = UIAlertController(title: "Success", message: "Deleted from Favorites", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.getFavorites()
        }
        alertVC.addAction(ok)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsDetails" {
            let destination = segue.destination as! NewsDetailsVC
            destination.urlString = selectedArticleUrl
        }
    }
    
}
