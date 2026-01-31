//
//  ChatCell.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 29.01.2026.
//

import SwiftUI
import Kingfisher

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
