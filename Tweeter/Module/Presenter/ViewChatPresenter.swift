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
        if !input.checkNumberCharacterHaveSpace(number: 50) {
            completion("Error Requirements 1.e")
            return
        }
        if input == "" {
            return
        }
        var startText = input.getFirstNCharacters(number: 50)
        var endText = input.getRestCharacterFrom(position: 50)
        let key1:Int = getKeyChat()
        interactor?.upContentChat(contentChat: startText , key: key1)
        tbv.reloadData()
        if startText == endText { return }
        while endText.count >= 1 {
            let key2:Int = getKeyChat()
            startText = endText.getFirstNCharacters(number: 50)
            endText = endText.getRestCharacterFrom(position: 50)
            interactor?.upContentChat(contentChat: startText , key: key2)
            tbv.reloadData()
            if startText == endText { return }
            if endText.count <= 50  {
                let key3:Int = getKeyChat()
                interactor?.upContentChat(contentChat: endText, key: key3)
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
