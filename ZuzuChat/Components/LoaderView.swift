//
//  ContentView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

struct LoaderView: View {
  var body: some View {
    ZStack {
      Image(.iconForLoader)
        .resizable()
    }
    .ignoresSafeArea()
    .overlay(alignment: .bottom) {
      CircularGrowingLoader()
        .padding(.bottom, 40)
    }
  }
}

#Preview {
  LoaderView()
}
