//
//  ShareView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 02.04.2025.
//

import SwiftUI

struct ShareView: View {
  @Binding var offsetY: CGFloat
  
  var body: some View {
    VStack(alignment: .leading, spacing: 25) {
      VStack(spacing: 20) {
        RoundedRectangle(cornerRadius: 2)
          .fill(Color.gray.opacity(0.4))
          .frame(width: 40, height: 4)
        
        Text("Send to")
          .font(.title2.bold().monospaced())
      }
      .frame(maxWidth: .infinity, alignment: .center)
      
      RoundedRectangle(cornerRadius: 0.5)
        .fill(.gray.opacity(0.4))
        .frame(height: 1)
      
      HStack(spacing: 25) {
        Button{} label: {
          VStack {
            Circle()
              .fill(Color(.pink))
              .frame(width: 60, height: 60)
              .overlay {
                Image(systemName: "arrow.up.forward.and.arrow.down.backward")
                  .resizable()
                  .frame(width: 20, height: 20)
              }
            Text("Report")
          }
        }
        Button{} label: {
          VStack {
            Image(.thor)
              .resizable()
              .scaledToFill()
              .frame(width: 60, height: 60)
              .clipShape(.circle)
            Text("Andrew")
          }
        }
        Button{} label: {
          VStack {
            Circle()
              .fill(Color(.pink.opacity(0.2)))
              .frame(width: 60, height: 60)
              .overlay {
                Image(systemName: "magnifyingglass")
                  .resizable()
                  .frame(width: 20, height: 20)
              }
            Text("Search")
          }
        }
      }
      .font(.footnote.monospaced())
      .padding(.horizontal, 20)
      .buttonStyle(.plain)
      
      RoundedRectangle(cornerRadius: 0.5)
        .fill(.gray.opacity(0.4))
        .frame(height: 1)
      
      VStack(spacing: 20) {
        HStack {
          item(section: "first", image: "Logo ProtoPie", text: "proto Pie")
          Spacer()
          item(section: "first", image: "Logo Sketch", text: "sketch")
          Spacer()
          item(section: "first", image: "Logo Figma", text: "figma")
          Spacer()
          item(section: "first", image: "Logo Framer", text: "framer")
        }
        
        HStack {
          item(section: "first", image: "Logo AE", text: "AE")
          Spacer()
          item(section: "first", image: "Logo React", text: "react")
          Spacer()
          item(section: "first", image: "Logo Principle", text: "Principle")
          Spacer()
          item(section: "first", image: "Logo SwiftUI", text: "SwiftUI")
        }
      }
      .padding(.horizontal, 10)
      
      RoundedRectangle(cornerRadius: 0.5)
        .fill(.gray.opacity(0.4))
        .frame(height: 1)
      
      VStack(spacing: 20) {
        HStack {
          item(section: "second", image: "exclamationmark.bubble.fill", text: "report")
          Spacer()
          item(section: "second", image: "bolt.heart", text: "interest")
          Spacer()
          item(section: "second", image: "square.and.arrow.down.fill", text: "save")
          Spacer()
          item(section: "second", image: "stopwatch.fill", text: "watch")
        }
        
        HStack {
          item(section: "second", image: "person.2.fill", text: "quest")
          Spacer()
          item(section: "second", image: "text.document.fill", text: "catch")
          Spacer()
          item(section: "second", image: "rectangle.stack.badge.plus", text: "add")
          Spacer()
          item(section: "second", image: "app.gift.fill", text: "gif")
        }
      }
      .padding(.horizontal, 10)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 40)
    .padding(.top, 10)
    .frame(width: UIScreen.main.bounds.width)
    .buttonStyle(.plain)
    .foregroundStyle(.white)
    .background(Color.bg)
    .clipShape(.rect(topLeadingRadius: 30, topTrailingRadius: 30))
    .offset(y: offsetY)
    .gesture(DragGesture().onChanged(onChanged).onEnded(onEnded))
  }
}

private extension ShareView {
    
  @ViewBuilder
  func item(section: String, image: String, text: String) -> some View {
    VStack(spacing: 10) {
      Button {} label: {
        Circle()
          .fill(Color(.pink.opacity(0.2)))
          .frame(width: 60, height: 60)
          .overlay {
            if section == "first" {
              Image(image)
                .resizable()
            } else {
              Image(systemName: image)
                .imageScale(.large)
                .foregroundStyle(Color(.pink))
            }
          }
      }
      
      Text(text.uppercased())
        .font(.footnote.monospaced())
    }
  }
  
  func onChanged(value: DragGesture.Value) {
    withAnimation(.spring) {
      if value.translation.height > 0 {
        offsetY = value.translation.height
      } else {
        return
      }
    }
  }
  
  func onEnded(value: DragGesture.Value) {
    withAnimation(.spring) {
      if offsetY < 100 {
        offsetY = 0
      } else {
        if value.translation.height > 0 {
          offsetY = UIScreen.main.bounds.height
        } else {
          return
        }
      }
    }
  }
}

#Preview {
    ShareView(offsetY: .constant(70))
}
