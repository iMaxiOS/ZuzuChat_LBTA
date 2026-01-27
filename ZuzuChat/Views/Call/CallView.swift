//
//  CallView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI


struct CallView: View {
  
  var body: some View {
    ZStack {
      Image(.man)
        .resizable()
        .scaledToFill()
        .frame(width: 150, height: 200)
        .clipShape(.rect(cornerRadius: 15))
        .padding(.top, 40)
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .shadow(radius: 10)
      
      ZStack {
        HStack(spacing: 12) {
          Button {} label: {
            Image(systemName: "ellipsis.message")
              .frame(width: 20, height: 20)
              .padding()
              .clipShape(.circle)
              .glassEffect(.clear, in: .circle)
          }
          Button {} label: {
            Image(systemName: "video.slash")
              .frame(width: 20, height: 20)
              .padding()
              .clipShape(.circle)
              .glassEffect(.clear, in: .circle)
          }
          
          Button {} label: {
            Image(systemName: "phone.down.fill")
              .padding(40)
              .background(LinearGradient(colors: [Color(.systemRed), Color(.pink)], startPoint: .topLeading, endPoint: .bottomTrailing))
              .frame(width: 20, height: 20)
              .padding(25)
              .clipShape(.circle)
              .glassEffect(.clear, in: .circle)
          }
          Button {} label: {
            Image(systemName: "rectangle.on.rectangle")
              .frame(width: 20, height: 20)
              .padding()
              .glassEffect(.clear, in: .circle)
          }
          Button {} label: {
            Image(systemName: "applepencil.adapter.usb.c")
              .frame(width: 20, height: 20)
              .padding()
              .glassEffect(.clear, in: .circle)
          }
        }
        .foregroundStyle(.white)
      }
      .frame(height: 90)
      .clipShape(.capsule)
      .padding(.horizontal, 10)
      .padding(.bottom, 100)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    .background(
        Image(.girl)
          .resizable()
          .scaledToFill()
    )
    .ignoresSafeArea()
  }
}

#Preview {
  CallView()
}
