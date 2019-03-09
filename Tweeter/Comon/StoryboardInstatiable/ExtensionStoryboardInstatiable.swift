//
//  ExtensionNib.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/9/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import UIKit
extension NSObject {
    public class var className:String {
        get {
            return NSStringFromClass(self).components(separatedBy: ".").last!
        }
    }
    
}

protocol StoryboardInstatiable {}

func instantiate<T: StoryboardInstatiable>(_: T.Type) -> T where T: NSObject {
    let storyboard = UIStoryboard(name: T.className, bundle: nil)
    return storyboard.instantiateInitialViewController() as! T
}

func instantiate<T: StoryboardInstatiable>(_: T.Type, storyboard: String) -> T where T: NSObject {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: T.className) as! T
}

extension UIViewController: StoryboardInstatiable {}
