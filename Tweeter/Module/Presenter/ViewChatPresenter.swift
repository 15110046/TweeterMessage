//
//  ViewChatControllerPresenter.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation

protocol ViewChatPresenter {
    func numberOfRowsInSection() -> Int
    func dataForRow(at indexPath: IndexPath) -> [ModelContentViewChat]
    func sendData(from input: String,tbv: ViewChatControllerInterFace, completion: (String)->())
    func dataForRow() -> [ModelContentViewChat]
}
class ViewChatPresenterImp {
    
    private var interactor: ViewChatInteractor?
    private var router: ViewChatRouter?
    
    init(interactor: ViewChatInteractor, router: ViewChatRouter, tbView: ViewChatControllerInterFace) {
        self.interactor = interactor
        self.router = router
    }
    
    private func getKeyChat() -> Int {
        let defaults = UserDefaults.standard
        let key = defaults.value(forKey: "keyChat") as? Int ?? 0
        defaults.set(key + 1, forKey: "keyChat")
        return defaults.value(forKey: "keyChat") as? Int ?? 0
    }
}
extension ViewChatPresenterImp: ViewChatPresenter {
    func dataForRow() -> [ModelContentViewChat] {
        return interactor?.getData() ?? [ModelContentViewChat]()
    }
    func sendData(from input: String,tbv: ViewChatControllerInterFace, completion: (String)->()) {
        if input.checkAllCharacterSpace() { return }
        if !input.checkNumberCharacterHaveSpace(number: 49) {
            completion("Error Requirements 1.e")
            return
        }
        if input == "" {
            return
        }
        var startText = input.getFirstNCharacters(number: 50)
        var endText = input.getRestCharacterFrom(position: 50)
        var sumCount = 0
        if input.count % 50 == 0 {
            sumCount = Int(input.count/50)
        }
        else {
            sumCount = Int(input.count / 50) + 1
        }
        var count = 0
        let key1:Int = getKeyChat()
        count = 1
        if input.count < 50 { interactor?.upContentChat(contentChat: startText , key: key1) }
        else { interactor?.upContentChat(contentChat: "\(count)/\(sumCount) " + startText , key: key1) }
        tbv.reloadData()
        if startText == endText { return }
        while endText.count >= 1 {
            let key2:Int = getKeyChat()
            count = count + 1
            startText = endText.getFirstNCharacters(number: 49)
            endText = endText.getRestCharacterFrom(position: 49)
            interactor?.upContentChat(contentChat: "\(count)/\(sumCount) " + startText , key: key2)
            tbv.reloadData()
            if startText == endText { return }
            if endText.count <= 49  {
                let key3:Int = getKeyChat()
                count = count + 1
                  interactor?.upContentChat(contentChat: "\(count)/\(sumCount) " + endText , key: key3)
                tbv.reloadData()
                break
            }
        }
    }
    
    func dataForRow(at indexPath: IndexPath) -> [ModelContentViewChat] {
        return interactor?.getData() ?? [ModelContentViewChat]()
    }
    
    func numberOfRowsInSection() -> Int {
        return interactor?.numberOfItemInData() ?? 0
    }
}
