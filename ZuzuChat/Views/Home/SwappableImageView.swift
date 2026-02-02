//
//  SwappableImageView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI

struct SwappableImageView: View {
  private let images: [String] = ["scarlet", "thor", "panther"]
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(images, id: \..self) { imageName in
          Image(imageName)
            .resizable()
            .scaledToFill()
            .containerRelativeFrame(.vertical)
            .scrollTargetLayout()
        }
      }
    }
    .scrollTargetBehavior(.paging)
    .ignoresSafeArea()
  }
}
