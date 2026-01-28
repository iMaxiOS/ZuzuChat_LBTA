//
//  SocialButtonsView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 28.01.2026.
//

import SwiftUI

struct SocialButtonsView: View {
  var body: some View {
    HStack(spacing: 20) {
      Button {
        
      } label: {
        Image(.facebook)
          .resizable()
          .renderingMode(.template)
          .frame(width: 15, height: 15)
          .padding(.vertical)
          .padding(.horizontal, 25)
          .background(.grayBlue)
          .clipShape(.rect(cornerRadius: 20))
      }
      .glassEffect(.clear, in: .capsule)
      
      Button {
        
      } label: {
        Image(.google)
          .resizable()
          .renderingMode(.template)
          .frame(width: 15, height: 15)
          .padding(.vertical)
          .padding(.horizontal, 25)
          .background(.grayBlue)
          .clipShape(.rect(cornerRadius: 20))
      }
      .glassEffect(.clear, in: .capsule)
      
      Button {
        
      } label: {
        Image(systemName: "apple.logo")
          .resizable()
          .renderingMode(.template)
          .frame(width: 15, height: 15)
          .padding(.vertical)
          .padding(.horizontal, 25)
          .background(.grayBlue)
          .clipShape(.rect(cornerRadius: 20))
      }
      .glassEffect(.clear, in: .capsule)
    }
    .padding(.bottom)
  }
}
