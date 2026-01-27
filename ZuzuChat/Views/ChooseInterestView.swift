//
//  ChooseInterestView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI

struct ChooseInterestView: View {
  @Bindable var session: SessionManager
  @Environment(AppRouterManager.self) private var router
  
  @State private var selectedTags: Set<String> = []
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        Text("Choose your interests and get the best video recommendations.")
          .font(.footnote.bold().monospaced())
          .padding(.horizontal, 10)
        
        TagCloudView(session: session, selectedTags: $selectedTags)
          .padding(.horizontal, 10)
//          .environment(session)
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            router.push(AppRouterType.aboutYourSelf)
          } label: {
            Text("Skip")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(.grayBlue)
              .clipShape(.rect(cornerRadius: 50))
          }
          
          Button {
            session.user.interests = selectedTags
            router.push(AppRouterType.aboutYourSelf)
          } label: {
            Text("Continue")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(Color(.pink)))
              .clipShape(.rect(cornerRadius: 50))
          }
        }
        .padding(.horizontal, 10)
      }
    }
    .foregroundStyle(.white)
    .navigationTitle(Text("Choose Your Interests"))
  }
}

#Preview {
  ChooseInterestView(session: .init())
    .environment(SessionManager())
}

struct TagCloudView: View {
  @Bindable var session: SessionManager
  
  @Binding var selectedTags: Set<String>
  
  let tags: [String] = [
    "Entertainment", "Gaming", "Art", "Animals", "Comedy",
    "Dance", "Beauty", "Music", "Food & Drink", "Sports", "DIY",
    "Science & Education", "Travel", "Family", "Anime & Movie",
    "Technology", "Outdoors", "Culture", "Health", "Comics"
  ]
  
  var body: some View {
    GeometryReader { geometry in
      let availableWidth = geometry.size.width
      
      FlexibleView(availableWidth: availableWidth, data: tags, spacing: 10) { tag in
        TagView(title: tag, isSelected: selectedTags.contains(tag)) {
          toggleSelection(tag)
        }
      }
      .padding(.vertical)
    }
  }
  
  private func toggleSelection(_ tag: String) {
    if selectedTags.contains(tag) {
      selectedTags.remove(tag)
    } else {
      selectedTags.insert(tag)
    }
  }
}

struct TagView: View {
  let title: String
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Text(title)
      .font(.footnote.bold().monospaced())
      .padding()
      .background(isSelected ? Color(Color(.pink)) : Color.clear)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color(.pink), lineWidth: 1)
      )
      .foregroundColor(isSelected ? Color.white : Color(Color(.pink)))
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .onTapGesture {
        action()
      }
  }
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
  let availableWidth: CGFloat
  let data: Data
  let spacing: CGFloat
  let content: (Data.Element) -> Content
  
  @State private var elementsSize: [Data.Element: CGSize] = [:]
  
  var body: some View {
    var rows: [[Data.Element]] = []
    var currentRow: [Data.Element] = []
    var currentWidth: CGFloat = 0
    
    for element in data {
      let elementWidth = elementsSize[element, default: CGSize(width: availableWidth, height: 40)].width + spacing
      
      if currentWidth + elementWidth > availableWidth {
        rows.append(currentRow)
        currentRow = [element]
        currentWidth = elementWidth
      } else {
        currentRow.append(element)
        currentWidth += elementWidth
      }
    }
    if !currentRow.isEmpty { rows.append(currentRow) }
    
    return VStack(alignment: .leading, spacing: 20) {
      ForEach(rows, id: \.self) { row in
        HStack(spacing: spacing) {
          ForEach(row, id: \.self) { element in
            content(element)
              .background(
                GeometryReader { proxy in
                  Color.clear
                    .onAppear {
                      elementsSize[element] = proxy.size
                    }
                }
              )
          }
        }
      }
    }
  }
}
