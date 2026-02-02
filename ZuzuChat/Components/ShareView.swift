//
//  ShareView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 02.04.2025.
//

import SwiftUI

struct ShareView: View {
  
  var body: some View {
    VStack(alignment: .leading, spacing: 25) {
      title
      topSection
      divider
      middleSection
      divider
      bottomSection
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding(.horizontal, 10)
    .buttonStyle(.plain)
    .clipShape(.rect(topLeadingRadius: 30, topTrailingRadius: 30))
    .presentationDetents([.height(Screen.height * 0.8)])
    .presentationBackground(.bg)
  }
}

private extension ShareView {
  enum sectionType: String, CaseIterable {
    case first, second
  }
  
  var title: some View {
    VStack(spacing: 8) {
      RoundedRectangle(cornerRadius: 2)
        .frame(width: 35, height: 5)
        .foregroundStyle(Color(.systemGray3))
      Text("Send to")
        .font(.title2.bold().monospaced())
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 25)
    }
    .padding(.top, 5)
  }
  
  var topSection: some View {
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
  }
  
  var middleSection: some View {
    VStack(spacing: 20) {
      HStack {
        item(image: "Logo Sketch", text: "sketch")
        Spacer()
        item(image: "Logo ProtoPie", text: "proto Pie")
        Spacer()
        item(image: "Logo Figma", text: "figma")
        Spacer()
        item(image: "Logo Framer", text: "framer")
      }
      
      HStack {
        item(image: "Logo AE", text: "AE")
        Spacer()
        item(image: "Logo React", text: "react")
        Spacer()
        item(image: "Logo Principle", text: "Principle")
        Spacer()
        item(image: "Logo SwiftUI", text: "SwiftUI")
      }
    }
  }
  
  var bottomSection: some View {
    VStack(spacing: 20) {
      HStack {
        item(section: .second, image: "exclamationmark.bubble.fill", text: "report")
        Spacer()
        item(section: .second, image: "bolt.heart", text: "interest")
        Spacer()
        item(section: .second, image: "square.and.arrow.down.fill", text: "save")
        Spacer()
        item(section: .second, image: "stopwatch.fill", text: "watch")
      }
      
      HStack {
        item(section: .second, image: "person.2.fill", text: "quest")
        Spacer()
        item(section: .second, image: "text.document.fill", text: "catch")
        Spacer()
        item(section: .second, image: "rectangle.stack.badge.plus", text: "add")
        Spacer()
        item(section: .second, image: "app.gift.fill", text: "gif")
      }
    }
  }
    
  @ViewBuilder
  func item(section: sectionType = .first, image: String, text: String) -> some View {
    VStack(spacing: 10) {
      Button {} label: {
        Circle()
          .fill(Color(.pink.opacity(0.2)))
          .frame(width: 60, height: 60)
          .overlay {
            if section == .first {
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
  
  var divider: some View {
    RoundedRectangle(cornerRadius: 0.5)
      .fill(.gray.opacity(0.4))
      .frame(height: 1)
  }
}

#Preview {
    ShareView()
}
