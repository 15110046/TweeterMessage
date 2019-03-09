//
//  ModelContentViewChat.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation

struct ModelContentViewChat {
    var contentChat: String
    var key: Int
    init(object: [String: Any]) {
        if let dic = object as? Dictionary<String, Any> {
            self.contentChat = dic["content"]  as? String ?? ""
            self.key = dic["key"] as? Int ?? 0
        }
        else {
             self.contentChat = ""
            self.key = 0
        }
        
    }
    
}
