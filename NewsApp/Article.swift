//
//  Article.swift
//  NewsApp
//
//  Created by Songyee Park on 5/2/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article: Mappable {
    var author: String = ""
    var title: String = ""
    var url: String = ""
    var description: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    
    required init(jsonData: JSON) {
        self.author = jsonData["author"].stringValue
        self.title = jsonData["title"].stringValue
        self.url = jsonData["url"].stringValue
        self.description = jsonData["description"].stringValue
        self.urlToImage = jsonData["urlToImage"].stringValue
        self.publishedAt = jsonData["publishedAt"].stringValue
    }
}
