//
//  ExtensionTableView.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    
    func scrollToBottom() {
        if self.numberOfRows(inSection:  self.numberOfSections - 1) > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(
                    row: (self.numberOfRows(inSection:  self.numberOfSections - 1) - 1),
                    section: self.numberOfSections - 1)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
