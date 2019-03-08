//
//  ViewChatControllerInteractor.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation
import UIKit
protocol ViewChatInteractor {
    func numberOfItemInData() -> Int
    func getData() -> [ModelContentViewChat]
    func upContentChat(contentChat: String, key: Int)
}
class ViewChatInteractorImp: ViewChatInteractor {
    func upContentChat(contentChat: String, key: Int) {
        ServiceOnline.share.pushData(param: contentChat, key: key)
    }
    func getData() -> [ModelContentViewChat] {
        return dataViewChat
    }
    func numberOfItemInData() -> Int {
        return dataViewChat.count
    }
    private var dataViewChat: [ModelContentViewChat] = []
    
    init(param: String, completion:@escaping (Bool) -> () ) {
        ServiceOnline.share.getData(param: param) { [weak self] (snapShot) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.dataViewChat.removeAll()
                print(snapShot)
                guard let data = snapShot as?  [String:[String: Any]]
                    else { return }
                let data2 = data.sorted{ $0.key < $1.key }
                
                self.dataViewChat = data2.map{ ModelContentViewChat(object: $0.value) }
                UserDefaults.standard.set(self.dataViewChat[self.dataViewChat.count-1].key, forKey: "keyChat")
                
                completion(true)
            }
        }
        
        
    }
}


