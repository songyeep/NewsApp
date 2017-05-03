//
//  FavoriteArticle.swift
//  NewsApp
//
//  Created by Songyee Park on 5/3/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteArticle: Object {
    dynamic var author = ""
    dynamic var title = ""
    dynamic var url = ""
}
