//
//  ViewController.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/6/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrResult = [String]()
    var stringTest = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself so I don't have to do it myself messages, so I don't have to do it myself  so I don't have to do it myself."
    var testString = "qwiebiqwubeiuqwbeoqh9uqwheno qwnioenqwoenqwoebqwoienqowineoiqnwoienqwe"
    var txt = "qwiebiqwubeiuqwbeoqh9uqwhenoqwnioen qwoenqwoebqwoienqowineoiqnwoienqwe"
    override func viewDidLoad() {
        super.viewDidLoad()
        //        sendData(from: stringTest)
        print(txt.count)
//        if kiemTra50KiTuCuaTuCoKhoangTrangKhong(string: testString) == true {
//            print("thoả ")
//        }
//        else { print(" không thoả ")}
        if testString.check50CharacterHaveSpace() == true {
            print("thoả")
        }
        else { print(" không thoả ") }
    }
    
    func kiemTra50KiTuCuaTuCoKhoangTrangKhong(string: String) -> Bool {

        var i = 0
       
        
        while i < string.count - 1 {
            if string[i] == " " {
                i = i + 1
                if (i + 50 < string.count-1) {
                    if checkToanKiTuKhongCoKhoangTrang(string: string[i..<i+50]) == false {   //50 kí tự có khoảng trắng
                        i = i + 1
                    }
                    else {
                        return false // 50 kí tự của từ k có khoảng trắng
                    }
                }
                else {
                    if checkToanKiTuKhongCoKhoangTrang(string: string[i..<string.count-1]) == false {   //50 kí tự có khoảng trắng
                        
                        i = i + 1
                    }
                    else {
                        if string[i..<string.count-1].count < 50 {
                            return true
                        }
                        return false // 50 kí tự của từ k có khoảng trắng
                    }
                }
            }
            else {
                if (i + 50 < string.count-1) {
                    if checkToanKiTuKhongCoKhoangTrang(string: string[i..<i+50]) == false {
                        i = i + 1
                    }
                    else {
                        return false // 50 kí tự của từ k có khoảng trắng
                    }
                }
                else {
                    if checkToanKiTuKhongCoKhoangTrang(string: string[i..<string.count-1]) == false {
                        i = i + 1
                    }
                    else {
                        if string[i..<string.count-1].count < 50 {
                            return true
                        }
                        return false
                    }
                }
            }
        }
        return true
    }
    func checkToanKiTuKhongCoKhoangTrang(string: String) -> Bool {
        for i in string {
            if i == " " {
                return false
            }
        }
        return true
    }
    
    func checkToanKiTuTrong(string: String) -> Bool {
        for i in string {
            if i != " " {
                return false
            }
        }
        return true
    }
}


