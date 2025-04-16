//
//  Ext+String.swift
//  be_friends
//
//  Created by Maxim Hranchenko on 20.06.2023.
//

import SwiftUI

extension String {
  subscript(idx: Int) -> String {
    String(self[index(startIndex, offsetBy: idx)])
  }
  
  func formattedMask(text: String, mask: String?) -> String {
    let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    var result = ""
    var index = cleanPhoneNumber.startIndex
    if let mask = mask {
      for ch in mask where index < cleanPhoneNumber.endIndex {
        if ch == "X" {
          result.append(cleanPhoneNumber[index])
          index = cleanPhoneNumber.index(after: index)
        } else {
          result.append(ch)
        }
      }
    }
    return result
  }
  
  func removingLeadingSpaces() -> String {
    guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
      return self
    }
    return String(self[index...])
  }
  
  func secureAmount() -> String {
    let secureString = String(repeating: "••••••", count: 1)
    return secureString
  }
}
