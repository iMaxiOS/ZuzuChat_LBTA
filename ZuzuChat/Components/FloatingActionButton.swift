//
//  FloatingActionButton.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 08.04.2025.
//

import SwiftUI

struct FloatingActionButton: View {
  @State private var isExpanded = false
  
  var body: some View {
    ZStack {
      if isExpanded {
        VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
          .ignoresSafeArea()
      }
      
      ZStack(alignment: .bottomTrailing) {
        Group {
          FABVerticalItem(
            offset: isExpanded ? -240 : 0,
            icon: "message.fill",
            text: "New Chat",
            delay: 0.0
          )
          FABVerticalItem(
            offset: isExpanded ? -165 : 0,
            icon: "person.crop.circle.fill.badge.plus",
            text: "New Contact",
            delay: 0.05
          )
          FABVerticalItem(
            offset: isExpanded ? -90 : 0,
            icon: "person.3.fill",
            text: "New Group",
            delay: 0.1
          )
        }
        
        Button {
          withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
            isExpanded.toggle()
          }
        } label: {
          Image(systemName: "plus")
            .font(.title.bold())
            .foregroundColor(.white)
            .rotationEffect(.degrees(isExpanded ? 45 : 0))
            .frame(width: 75, height: 75)
            .clipShape(Circle())
            .shadow(radius: 4)
        }
        .glassEffect(.clear, in: .circle)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
      .padding(.bottom)
      .padding(.trailing, 10)
    }
    .buttonStyle(.plain)
  }
}

struct FABVerticalItem: View {
  var offset: CGFloat
  var icon: String
  var text: String
  var delay: Double
  
  var body: some View {
    Button { } label: {
      HStack(spacing: 16) {
        Image(systemName: icon)
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(.green)
        
        Text(text)
          .foregroundColor(.grayBlue)
          .font(.headline.bold().monospaced())
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(width: 160)
      .padding(20)
      .background(Color.white)
      .clipShape(Capsule())
      .shadow(radius: 2)
      .offset(y: offset)
      .opacity(offset == 0 ? 0 : 1)
      .animation(
        .spring(response: 0.35, dampingFraction: 0.7)
        .delay(delay), value: offset
      )
    }

  }
}

#Preview {
  FloatingActionButton()
}
