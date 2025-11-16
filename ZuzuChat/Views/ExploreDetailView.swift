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
        BackButton()
        
        VStack {
          KFImage(URL(string: new.imageUrl ?? "") ?? URL(string: ""))
            .resizable()
            .cacheMemoryOnly()
            .scaledToFill()
            .frame(width:  UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
            .clipShape(.rect(cornerRadius: 30))
          
          VStack(alignment: .leading, spacing: 15) {
            Text(new.title)
              .font(.title2.bold().monospaced())
            Text(new.description ?? "")
              .font(.headline)
              .foregroundStyle(.gray)
          }
          .padding(.horizontal, 15)
        }
        
        Spacer()
      }
    }
    .foregroundStyle(.white)
    .overlay(alignment: .top) {
      HStack {
        Text(new.sourceName)
          .font(.headline.bold().monospaced())
          .frame(maxWidth: 300, alignment: .center)
          .lineLimit(1)
          .padding(.top, 10)
      }
    }
  }
}

#Preview {
  ExploreDetailView(new: .init())
}
