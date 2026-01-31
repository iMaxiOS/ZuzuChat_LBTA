//
//  MoversRow.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI
import Kingfisher

struct MoversRow: View {
  var news: NewsResponse
  
  var body: some View {
    ZStack {
      KFImage(URL(string: news.imageUrl ?? "") ?? URL(string: ""))
        .resizable()
        .cacheMemoryOnly()
        .scaledToFill()
        .frame(width: Screen.width - 32, height: 150)
        .clipped()
      
      VStack(alignment: .leading, spacing: 5) {
        Text(news.title)
          .font(.headline.bold().monospaced())
          .lineLimit(1)
        Text(news.description ?? "")
          .font(.footnote)
          .lineLimit(3)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
      .padding(.horizontal, 10)
      .padding(.bottom, 10)
      .background(
        LinearGradient(
          colors: [Color.clear, Color.clear, Color.black],
          startPoint: .top,
          endPoint: .bottom
        )
      )
    }
    .clipShape(.rect(cornerRadius: 30))
    .shadow(color: .white.opacity(0.2), radius: 5)
    .padding(.horizontal)
  }
}
