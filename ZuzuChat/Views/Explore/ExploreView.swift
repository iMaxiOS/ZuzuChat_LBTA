//
//  ExploreView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI
import Kingfisher

struct ExploreView: View {
  @Environment(SessionManager.self) private var session
  @Environment(AppRouterManager.self) private var router
  
  @State private var vm = ExploreViewModel()
  @State private var sections: [CategorySection] = [
    CategorySection(title: "Finance", categories: [
      CategoryItem(title: "All Stack", icon: "✅", isSelected: true),
      CategoryItem(title: "Visionary", icon: "🚀"),
      CategoryItem(title: "Food & Drink", icon: "🍔"),
      CategoryItem(title: "Animal", icon: "🐒"),
    ]),
    CategorySection(title: "Watch", categories: [
      CategoryItem(title: "Movie", icon: "🎬"),
      CategoryItem(title: "Music", icon: "🎵"),
      CategoryItem(title: "Games", icon: "🎮"),
      CategoryItem(title: "Photo", icon: "📷"),
    ]),
    CategorySection(title: "Cars", categories: [
      CategoryItem(title: "Car", icon: "🚗"),
      CategoryItem(title: "Motobike", icon: "🏍"),
      CategoryItem(title: "Electro car", icon: "⚡"),
      CategoryItem(title: "Truck", icon: "🚛"),
    ]),
    CategorySection(title: "Techno", categories: [
      CategoryItem(title: "Apple", icon: "🍏"),
      CategoryItem(title: "Microsoft", icon: "🖥"),
      CategoryItem(title: "Gadget", icon: "📱"),
      CategoryItem(title: "Player", icon: "📀"),
    ])
  ]
  
  private let moversList: [Movers] = [
    .init(icon: "Logo AE", title: "AE", percent: "+10%"),
    .init(icon: "Logo Figma", title: "Figma", percent: "+4.3%"),
    .init(icon: "Logo Sketch", title: "Sketch", percent: "+4.8%"),
    .init(icon: "Logo React", title: "React", percent: "+12.3%"),
    .init(icon: "Logo SwiftUI", title: "SwiftUI", percent: "+22.3%"),
    
  ]
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      content
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {} label: {
          Image(systemName: "00.circle.ar")
            .imageScale(.large)
        }
      }
    }
    .task {
      await vm.fetchArticles()
    }
  }
}


#Preview {
  ExploreView()
    .environment(AppRouterManager())
    .environment(SessionManager())
}

private extension ExploreView {
  var content: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          Image(systemName: "magnifyingglass")
            .renderingMode(.template)
            .foregroundStyle(.gray)
          TextField("", text: $vm.searchText, prompt: Text("Search news"))
            .padding(.vertical)
            .onChange(of: vm.searchText) { oldValue, newValue in
              vm.searchArticles()
            }
        }
      }
      .padding(.horizontal)
      .glassEffect(.clear, in: .rect(cornerRadius: 20))
      .padding(.bottom, 5)
      .padding(.horizontal, 10)
      
      VStack(alignment: .leading, spacing: 16) {
        if vm.searchText.isEmpty {
          ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
              ForEach($sections) { section in
                HStack(spacing: 16) {
                  ForEach(section.categories) { category in
                    CategoryChip(category: category)
                  }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
              }
            }
            .padding(.top)
            .padding(.horizontal)
          }
          
//          HStack {
//            Text("Top Movers")
//              .font(.headline.bold().monospaced())
//            Spacer()
//            Button {} label: {
//              Image(systemName: "arrow.right")
//                .foregroundStyle(Color(.pink))
//                .padding()
//            }
//          }
//          .padding(.horizontal)
//          
//          ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 14) {
//              ForEach(moversList) { item in
//                MoversTopRow(item: item)
//              }
//            }
//            .padding(.horizontal)
//          }
        }
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 16) {
            ForEach(vm.articles, id: \.articleId) { news in
              MoversRow(news: news)
                .onTapGesture {
                  router.push(AppRouterType.explore(new: news))
                }
            }
          }
          .padding(.vertical, 10)
        }
      }
      .padding(.bottom, 50)
    }
    .refreshable {
      await vm.fetchArticles()
    }
  }
}
