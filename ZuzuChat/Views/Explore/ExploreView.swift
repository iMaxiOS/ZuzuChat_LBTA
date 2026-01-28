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
      
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: 0) {
          RoundedRectangle(cornerRadius: 15)
            .fill(.grayBlue)
            .frame(height: 60)
            .overlay {
              HStack {
                Image(systemName: "magnifyingglass")
                  .renderingMode(.template)
                  .foregroundStyle(.gray)
                TextField("", text: $vm.searchText, prompt: Text("Search news").foregroundStyle(.gray))
                  .padding(.vertical)
                  .onChange(of: vm.searchText) { oldValue, newValue in
                    vm.searchArticles(query: newValue)
                  }
              }
              .padding(.horizontal)
              .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .padding(.horizontal)
          
          VStack(alignment: .leading, spacing: 16) {
            if vm.searchText.isEmpty {
              ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading) {
                  ForEach(sections) { section in
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
              
              HStack {
                Text("Top Movers")
                  .font(.headline.bold().monospaced())
                Spacer()
                Button {} label: {
                  Image(systemName: "arrow.right")
                    .foregroundStyle(Color(.pink))
                    .padding()
                }
              }
              .padding(.horizontal)
              
              ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                  ForEach(moversList) { item in
                    MoversTopRow(item: item)
                  }
                }
                .padding(.horizontal)
              }
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
      }
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

struct MoversTopRow: View {
  var item: Movers
  
  var body: some View {
    VStack(spacing: 10) {
      Image(item.icon)
        .resizable()
        .frame(width: 100, height: 100)
        .overlay {
          Circle()
            .stroke(Color(.pink), lineWidth: 4)
        }
      
      Text(item.title)
        .font(.headline.bold().monospaced())
      
      Text(item.percent)
        .font(.subheadline.bold())
        .foregroundStyle(Color(.pink))
    }
    .padding(4)
  }
}

struct MoversRow: View {
  var news: NewsResponse
  
  var body: some View {
    ZStack {
      KFImage(URL(string: news.imageUrl ?? "") ?? URL(string: ""))
        .resizable()
        .cacheMemoryOnly()
        .scaledToFill()
        .frame(width: Screen.width - 32, height: 150)
        .clipped()
      
      VStack(alignment: .leading, spacing: 5) {
        Text(news.title)
          .font(.headline.bold().monospaced())
          .lineLimit(1)
        Text(news.description ?? "")
          .font(.footnote)
          .lineLimit(3)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
      .padding(.horizontal, 10)
      .padding(.bottom, 10)
      .background(
        LinearGradient(
          colors: [Color.clear, Color.clear, Color.black],
          startPoint: .top,
          endPoint: .bottom
        )
      )
    }
    .clipShape(.rect(cornerRadius: 30))
    .shadow(color: .white.opacity(0.2), radius: 5)
    .padding(.horizontal)
  }
}

struct CategoryChip: View {
  @State var category: CategoryItem
  
  var body: some View {
    Text("\(category.icon) \(category.title)")
      .font(.system(size: 16, weight: .medium))
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(Color.gray.opacity(0.2))
      .cornerRadius(20)
      .background(
        category.isSelected ? Color(.pink).opacity(0.2) : Color.black.opacity(0.2)
      )
      .foregroundColor(category.isSelected ? Color(.pink) : .white)
      .clipShape(Capsule())
      .overlay(
        Capsule()
          .stroke(category.isSelected ? Color(.pink) : Color.gray, lineWidth: 1)
      )
      .onTapGesture {
        category.isSelected.toggle()
      }
  }
}

#Preview {
  ExploreView()
    .environment(AppRouterManager())
    .environment(SessionManager())
}
