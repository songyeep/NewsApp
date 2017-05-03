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
    var selectedArticleUrl: String = ""
    
    @IBOutlet weak var newsList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    

}

class AlertHelper {
    static func showError(_ message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertVC.addAction(close)
        return alertVC
    }
}
