//
//  ServiceOnline.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation
import Firebase

class ServiceOnline {
    static var share = ServiceOnline()
    private var ref = Database.database().reference()
    func getData(param: String, comletion: @escaping (_ data: Any?) -> ()) {
        ref.child("Tweeter").child(param).observe(.value) { (snapShot) in
            guard let value = snapShot.value else {
                DispatchQueue.main.async {
                    comletion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                comletion(value)
            }
        }
    }
    func pushData(param: String, key: Int) {
        let dicContentChat = ["content": param, "key": key] as [String : Any]
        ref.child("Tweeter").child("arrContent").child("\(key)").setValue(dicContentChat)
    }
}

