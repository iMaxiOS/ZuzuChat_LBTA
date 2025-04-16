//
//  ChatView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI
import Kingfisher

struct ChatView: View {
  @EnvironmentObject var session: SessionManager
  
  @State private var searchText: String = ""
  @State private var isShowNewContent: Bool = false
  @State private var vm = ExploreViewModel()
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center) {
            Text("Chats")
              .font(.title2.bold().monospaced())
            
            Spacer()
          }
          .padding(.horizontal, 20)
          
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
                  prompt: Text("Search chat, people and more ...").foregroundStyle(.gray)
                )
                  .padding(.vertical)
              }
              .padding(.horizontal)
              .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 5)
          
          ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
              ForEach(vm.articles, id: \.articleId) { article in
                ChatCell(article: article)
              }
            }
            .padding(.bottom, 60)
            .padding(.horizontal, 20)
            .padding(.top, 20)
          }
        }
      }
      .padding(.top)
      
      FloatingActionButton()
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
    .onAppear {
      vm.fetchArticles()
    }
  }
}

struct ChatCell: View {
  
  var article: NewsResponse
  
  var body: some View {
    HStack {
      KFImage(URL(string: article.imageUrl ?? "") ?? URL(string: ""))
        .resizable()
        .frame(width: 70, height: 70)
        .clipShape(.circle)
        .overlay(alignment: .bottomTrailing) {
          if article.sourceName != "The Daily Star" {
            Circle()
              .fill(.green)
              .frame(width: 15, height: 15)
              .offset(x: -3, y: -3)
          }
        }
      
      VStack(spacing: 10) {
        HStack {
          Text(article.sourceName)
            .font(.headline.bold().monospaced())
          
          Spacer()
          
          Text(formattedTime(from: article.pubDate))
            .font(.subheadline)
            .foregroundStyle(article.sourceName != "The Daily Star" ? .green : .gray)
        }
        
        HStack(spacing: 12) {
          Text(article.description ?? "")
            .font(.subheadline.monospaced())
            .foregroundStyle(.gray)
            .lineLimit(1)
          
          Spacer()
          
          if article.sourceName != "The Daily Star" {
            Circle()
              .fill(.green)
              .frame(width: 25, height: 25)
              .overlay {
                Text("2")
                  .font(.subheadline.bold())
              }
          }
        }
      }
    }
  }
}

private extension ChatCell {
  func formattedTime(from dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "hh:mm a"
    outputFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let date = inputFormatter.date(from: dateString) {
      return outputFormatter.string(from: date)
    } else {
      return "Incorrect date format"
    }
  }
}

#Preview {
  ChatView()
}
