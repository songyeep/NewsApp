//
//  AlertHelper.swift
//  NewsApp
//
//  Created by Songyee Park on 5/4/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    static func showError(_ message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertVC.addAction(close)
        return alertVC
    }
}
