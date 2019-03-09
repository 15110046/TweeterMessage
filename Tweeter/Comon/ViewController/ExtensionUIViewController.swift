//
//  ExtensionUIViewController.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/9/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
