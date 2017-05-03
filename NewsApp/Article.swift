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
    dynamic var author: String = ""
    dynamic var title: String = ""
    dynamic var url: String = ""
    
    required init(jsonData: JSON) {
        self.author = jsonData["author"].stringValue
        self.title = jsonData["title"].stringValue
        self.url = jsonData["url"].stringValue
    }
}
