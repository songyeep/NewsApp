//
//  NewsMainVC.swift
//  NewsApp
//
//  Created by Songyee Park on 5/2/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit
import Moya
import RealmSwift

class NewsMainVC: UIViewController {
    
    fileprivate let api = MoyaProvider<NewsAPI>()
    
    var articles = [Article]()
    var favorites = [FavoriteArticle]()
    var selectedArticleUrl: String = ""
    var showFavoritesOnly: Bool = false
    
    @IBOutlet weak var newsList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setInitialTableData() {
        let favorites = try! Realm().objects(FavoriteArticle.self)
        for favorite in favorites {
            self.favorites.append(favorite)
        }
        getNews()
    }
    
    func getFavorites() {
        self.favorites.removeAll()
        let favorites = try! Realm().objects(FavoriteArticle.self)
        for favorite in favorites {
            self.favorites.append(favorite)
        }
        newsList.reloadData()
    }
    
    func getNews() {
        api.request(.get) { (result) in
            if result.error != nil {
                let alertVC = AlertHelper.showError(result.error!.localizedDescription)
                self.present(alertVC, animated: true, completion: nil)
            } else {
                do {
                    let mappedArticles = try result.value?.mapArray(Article.self) ?? []
                    self.articles = mappedArticles
                    self.newsList.reloadData()
                } catch {
                    let alertVC = AlertHelper.showError(error.localizedDescription)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBOutlet weak var showFavoritesButton: UIBarButtonItem!
    @IBAction func showFavorites(_ sender: UIBarButtonItem) {
        if showFavoritesOnly == false {
            showFavoritesOnly = true
            showFavoritesButton.title = "All"
            navigationItem.title = "Favorite Articles"
            newsList.reloadData()
        } else {
            showFavoritesOnly = false
            showFavoritesButton.title = "Favorites"
            navigationItem.title = "Latest on Polygon"
            getFavorites()
        }
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
