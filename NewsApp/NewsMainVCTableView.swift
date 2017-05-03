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
        return articles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsList.dequeueReusableCell(withIdentifier: "articleTableCell", for: indexPath) as! NewsMainVCTableViewCell
        configureNewsTableCell(cell, articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        selectedArticleUrl = selectedArticle.url
        performSegue(withIdentifier: "toNewsDetails", sender: self)
    }
    
    func configureNewsTableCell(_ cell: NewsMainVCTableViewCell, _ article: Article) {
        cell.title.text = article.title
        cell.favoritesButtonPressed = {
            self.savedAsFavorite(article)
        }
    }
    
    func savedAsFavorite(_ article: Article) {
        let favoriteArticle = FavoriteArticle()
        favoriteArticle.title = article.title
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(favoriteArticle)
        }
        
        print("SAVED AS FAVORITE")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsDetails" {
            let destination = segue.destination as! NewsDetailsVC
            destination.urlString = selectedArticleUrl
        }
    }
    
}
