//
//  ExploreDetailView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.11.2025.
//

import SwiftUI
import Kingfisher

struct ExploreDetailView: View {
  let new: NewsResponse
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 15) {
        KFImage(URL(string: new.imageUrl ?? "") ?? URL(string: ""))
          .resizable()
          .cacheMemoryOnly()
          .scaledToFill()
          .frame(width: Screen.width, height: Screen.height / 3)
          .clipShape(.rect(cornerRadius: 30))
        
        VStack(alignment: .leading, spacing: 15) {
          Text(new.title)
            .font(.title3.bold())
          Text(new.description ?? "")
            .font(.headline)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal, 15)
        
        Spacer()
      }
    }
    .foregroundStyle(.white)
    .navigationTitle(Text(new.sourceName))
    .navigationBarTitleDisplayMode(.inline)
    .toolbarVisibility(.hidden, for: .tabBar)
  }
}

#Preview {
  ExploreDetailView(new: .init())
}
