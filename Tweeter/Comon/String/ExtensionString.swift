//
//  ExtensionString.swift
//  Tweeter
//
//  Created by Nguyen Hieu on 3/7/19.
//  Copyright © 2019 com.nguyenhieu.game. All rights reserved.
//

import Foundation

extension String {
    func getFirstNCharacters(number: Int) -> String {
        if self.count <= number {
            return self
        }
        
        if self.checkStringHaveMin1SpaceCharacter() {
            if self[number-4] != " " {
                return getFirstNCharacters(number: number - 1)
            }
        }
        else {
            return self[0..<number-4]
        }
        return self[0..<number-4]
    }
    func getRestCharacterFrom(position number: Int) -> String {
        if self.count <= number {
            return self
        }
        if self.checkStringHaveMin1SpaceCharacter() {
            if self[number-4] == " " {
                return self[number - 3..<self.count]
            }
        }
        else {
            return self[number - 3..<self.count]
        }
        return getRestCharacterFrom(position: number - 1)
    }
    
    func checkNumberCharacterHaveSpace(number: Int) -> Bool {
        var i = 0
        while i < self.count - 1 {
            if self[i] == " " {
                i = i + 1
                if (i + number < self.count-1) {
                    if self[i..<i+number].checkStringHaveMin1SpaceCharacter() {
                        i = i + 1
                    }
                    else {
                        return false
                    }
                }
                else {
                    if self[i..<self.count-1].checkStringHaveMin1SpaceCharacter() {
                        
                        i = i + 1
                    }
                    else {
                        if self[i..<self.count-1].count < number {
                            return true
                        }
                        return false
                    }
                }
            }
            else {
                if (i+number < self.count - 1) {
                    if self[i..<i+number].checkStringHaveMin1SpaceCharacter() {
                        i = i + 1
                    }
                    else {
                        return false 
                    }
                }
                else {
                    if self[i..<self.count-1].checkStringHaveMin1SpaceCharacter() {
                        i = i + 1
                    }
                    else {
                        if self[i..<self.count-1].count < number {
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
    
    func checkStringHaveMin1SpaceCharacter() -> Bool {
        for i in self {
            if i == " " {
                return true
            }
        }
        return false
    }
    
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
        }
        else { startIndex = self.startIndex }
        
        let endIndex: String.Index
        
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        }
        else { endIndex = self.endIndex }
        
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
