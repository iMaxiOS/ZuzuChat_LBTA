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
      Color.bg
        .ignoresSafeArea()
      
      Image(systemName: "video.and.waveform.fill")
        .resizable()
        .frame(width: 170, height: 100)
        .foregroundStyle(Color(.pink))
        .overlay {
          Text("Z")
            .font(.system(size: 45, weight: .bold))
            .foregroundStyle(.bg)
            .offset(y: -10)
        }
//        .transition(.scale(scale: 3))
    }
    .overlay(alignment: .bottom) {
      CircularGrowingLoader()
        .padding(.bottom, 40)
    }
  }
}

#Preview {
  LoaderView()
}
