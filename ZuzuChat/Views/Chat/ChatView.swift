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
            HStack {
              Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .foregroundStyle(.gray)
              
              TextField(
                "",
                text: $searchText,
                prompt: Text("Search chat, people and more ...")
              )
              .padding(.vertical)
            }
            .padding(.horizontal)
            .glassEffect(.clear, in: .rect(cornerRadius: 20))
            .padding(.bottom, 5)
            .padding(.horizontal, 10)
            
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
