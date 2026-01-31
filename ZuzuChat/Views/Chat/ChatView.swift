//
//  ChatView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI
import Kingfisher

struct ChatView: View {
  @Environment(SessionManager.self) private var session
  @Environment(AppRouterManager.self) private var router
  
  @State private var searchText: String = ""
  @State private var isShowNewContent: Bool = false
  @State private var vm = ExploreViewModel()
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          VStack(alignment: .leading, spacing: 0) {
            RoundedRectangle(cornerRadius: 15)
              .fill(.grayBlue)
              .frame(height: 60)
              .overlay {
                HStack {
                  Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
                  TextField(
                    "",
                    text: $searchText,
                    prompt: Text("Search chat, people and more ...").foregroundStyle(.white)
                  )
                  .padding(.vertical)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
              }
              .padding(.horizontal, 10)
              .padding(.top, 20)
              .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 16) {
              ForEach(vm.articles, id: \.articleId) { article in
                ChatCell(article: article)
                  .onTapGesture {
                    router.push(AppRouterType.message(article: article))
                  }
              }
            }
            .padding(.bottom, 60)
            .padding(.horizontal, 10)
            .padding(.top, 20)
          }
        }
      }
      
      FloatingActionButton()
    }
    .buttonStyle(.plain)
    .task {
      await vm.fetchArticles()
    }
  }
}

#Preview {
  ChatView()
    .environment(AppRouterManager())
    .environment(SessionManager())
}
