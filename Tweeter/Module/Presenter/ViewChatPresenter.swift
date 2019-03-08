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
    func sendData(from input: String,tbv: UpdataUITableView, completion: (String)->())
    func dataForRow() -> [ModelContentViewChat]
}
class ViewChatPresenterImp: ViewChatPresenter {
    var arrResult = [String]()
     func dataForRow() -> [ModelContentViewChat] {
        return interactor?.getData() ?? [ModelContentViewChat]()
    }

    func getKeyChat() -> Int {
         let defaults = UserDefaults.standard
        let key = defaults.value(forKey: "keyChat") as? Int ?? 0
        defaults.set(key + 1, forKey: "keyChat")
        return defaults.value(forKey: "keyChat") as? Int ?? 0
    }
    
    var defaultsKey: Int = UserDefaults.standard.object(forKey: "keyChat") as? Int ?? 0
   
    func sendData(from input: String,tbv: UpdataUITableView, completion: (String)->()) {
        if input.checkAllCharacterSpace() { return }
        if !input.check50CharacterHaveSpace() {
            completion("Error Requirements 1.e")
            return 
        }
        if input == "" {
            return
        }
        var startText = getFirst50Character(string: input, n: 50)
        var endText = getRestCharacter(string: input, n: 50)
        let key1:Int = getKeyChat()
        interactor?.upContentChat(contentChat: startText , key: key1)
        tbv.reloadData()
        if startText == endText { return }
        while endText.count >= 1 {
            let key2:Int = getKeyChat()
            startText = getFirst50Character(string: endText, n: 50)
            endText = getRestCharacter(string: endText, n: 50)
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
    func checkStringHaveSpaceCharacter(string: String) -> Bool {
        for i in string {
            if i == " " {
                return true
            }
        }
        return false
        
        
    }
    
    func getFirst50Character(string:String, n: Int) -> String {
        if string.count <= n {
            return string
        }
        if checkStringHaveSpaceCharacter(string: string) {
            if string[n] != " " {
                return getFirst50Character(string: string, n: n-1)
            }
        }
        else {
            return string[0..<n]
        }
        return string[0..<n]
    }
    func getRestCharacter(string:String, n: Int) -> String {
        if string.count <= n {
            return string
        }
        if checkStringHaveSpaceCharacter(string: string) {
            if string[n] == " " {
                return string[n+1..<string.count]
            }
        }
        else {
              return string[n+1..<string.count]
        }
        return getRestCharacter(string: string, n: n-1)
    }

    func dataForRow(at indexPath: IndexPath) -> [ModelContentViewChat] {
        return interactor?.getData() ?? [ModelContentViewChat]()
    }
 
    private var interactor: ViewChatInteractor?
    private var router: ViewChatRouter?
    
    init(interactor: ViewChatInteractor, router: ViewChatRouter, tbView: UpdataUITableView) {
        self.interactor = interactor
        self.router = router
    }
    func numberOfRowsInSection() -> Int {
        return interactor?.numberOfItemInData() ?? 0
    }
}
