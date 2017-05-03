//
//  JSONResponseMapper.swift
//  NewsApp
//
//  Created by Songyee Park on 5/2/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import SwiftyJSON
import Moya
import Result

public protocol Mappable {
    init?(jsonData: JSON)
}

public extension Response {
    public func mapArray<T: Mappable>(_ type:T.Type) throws -> [T] {
        let jsonObject = try mapJSON()
        let responseDictionary = JSON(jsonObject)["articles"]
        if let items = responseDictionary.array {
            if items.count > 0 {
                let mappedObjectsArray = items.flatMap { T(jsonData: $0) }
                return mappedObjectsArray
            } else {
                return []
            }
        }
        let mappedArray = JSON(jsonObject)
        let mappedObjectsArray = mappedArray.arrayValue.flatMap { T(jsonData: $0) }
        return mappedObjectsArray
    }
}
