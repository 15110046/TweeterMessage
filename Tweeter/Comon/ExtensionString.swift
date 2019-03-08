//
//  ExtensionString.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation
extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
}
extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}


extension String {
    func check50CharacterHaveSpace() -> Bool {
        var i = 0
        while i < self.count - 1 {
            if self[i] == " " {
                i = i + 1
                if (i + 50 < self.count-1) {
                    if self[i..<i+50].checkAllCharacterHaventSpace() == false {   //50 kí tự có khoảng trắng
                        i = i + 1
                    }
                    else {
                        return false // 50 kí tự của từ k có khoảng trắng
                    }
                }
                else {
                    if self[i..<self.count-1].checkAllCharacterHaventSpace() == false {   //50 kí tự có khoảng trắng
                        
                        i = i + 1
                    }
                    else {
                        if self[i..<self.count-1].count < 50 {
                            return true
                        }
                        return false // 50 kí tự của từ k có khoảng trắng
                    }
                }
            }
            else {
                if (i+50 < self.count - 1) {
                    if self[i..<i+50].checkAllCharacterHaventSpace() == false {
                        i = i + 1
                    }
                    else {
                        return false // 50 kí tự của từ k có khoảng trắng
                    }
                }
                else {
                    if self[i..<self.count-1].checkAllCharacterHaventSpace() == false {
                        i = i + 1
                    }
                    else {
                        if self[i..<self.count-1].count < 50 {
                            return true
                        }
                        return false
                    }
                }
            }
        }
        return true
    }
    func checkAllCharacterSpace() -> Bool {
        for i in self {
            if i != " " {
                return false
            }
        }
        return true
    }
    func checkAllCharacterHaventSpace() -> Bool {
        for i in self {
            if i == " " {
                return false
            }
        }
        return true
    }
}
