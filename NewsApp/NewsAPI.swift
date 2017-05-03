//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Songyee Park on 5/2/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import SwiftyJSON
import Moya

enum NewsAPI {
    case get
}

extension NewsAPI: TargetType {
    var baseURL: URL {
        var urlString = "https://newsapi.org/v1/articles"
        urlString += "?source=polygon"
        urlString += "&apiKey=ccf3b62f6ba04f1980a32d44f3f84335"
        return URL(string: urlString)!
    }
    var path: String {
        switch self {
        default:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .get:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
    var validate: Bool {
        switch self {
        default:
            return true
        }
    }
}
