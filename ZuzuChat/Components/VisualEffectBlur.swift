//
//  VisualEffectBlur.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 08.04.2025.
//

import SwiftUI

struct VisualEffectBlur: UIViewRepresentable {
  var blurStyle: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
