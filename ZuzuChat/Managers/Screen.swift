//
//  Screen.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.01.2026.
//

import UIKit

enum Screen {
  static var size: CGSize {
    guard let scene = UIApplication.shared.connectedScenes
      .compactMap({ $0 as? UIWindowScene })
      .first
    else {
      return .zero
    }
    
    return scene.screen.bounds.size
  }
  
  static var width: CGFloat {
    size.width
  }
  
  static var height: CGFloat {
    size.height
  }
}
