//
//  Ext+Image.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 01.04.2025.
//

import Foundation
import UIKit

func base64ToImage(_ base64String: String) -> UIImage? {
  guard let imageData = Data(base64Encoded: base64String) else { return nil }
  return UIImage(data: imageData)
}

extension UIImage {
  func base64ToImage(_ base64String: String) -> UIImage? {
    guard let imageData = Data(base64Encoded: base64String) else { return nil }
    return UIImage(data: imageData)
  }
}
