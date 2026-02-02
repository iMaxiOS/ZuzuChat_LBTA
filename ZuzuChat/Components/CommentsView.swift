//
//  CommentsView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI

struct CommentItem: Identifiable {
  let id: UUID = UUID()
  let photo: String
  let name: String
  let comment: String
  let like: String
  let ago: String
  
  static let comments: [CommentItem] = [
    .init(photo: "thor", name: "Kristian Thor", comment: "Screen you provided, targeting iOS 17. This layout includes", like: "544", ago: "5 days ago"),
    .init(photo: "panther", name: "Maxim Mashilhin", comment: "Here's a, targeting iOS 17. This layout includes", like: "322", ago: "2 days ago"),
    .init(photo: "scarlet", name: "David Karlson", comment: "Here's a SwiftUI implementation of the screen you", like: "544", ago: "1 days ago")
  ]
}

struct CommentsView: View {
  private let commentsMock = CommentItem.comments
  
  @State private var addCommentText: String = ""
  
  var body: some View {
    VStack(spacing: 20) {
      Text("\(CommentItem.comments.count) Comments")
        .font(.title2.bold().monospaced())
      
      ForEach(commentsMock) { mock in
        item(mock)
      }
      Spacer()
    }
    .padding(.horizontal, 10)
    .padding([.top, .bottom], 25)
    .clipShape(.rect(topLeadingRadius: 30, topTrailingRadius: 30))
    .presentationDetents([.medium, .large])
    .presentationBackground(.bg)
  }
}

private extension CommentsView {
    
  @ViewBuilder
  func item(_ item: CommentItem) -> some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 15) {
        Image(item.photo)
          .resizable()
          .frame(width: 60, height: 60)
          .clipShape(.circle)
        
        Text(item.name)
          .font(.headline.bold().monospaced())
        
        Spacer()
      }
      
      Text(item.comment)
        .font(.subheadline)
        .lineLimit(2)
      
      HStack(spacing: 10) {
        Image(systemName: "heart.fill")
          .imageScale(.large)
          .foregroundStyle(Color(.pink))
        Text(item.like)
          .font(.caption)
        Text(item.ago)
          .font(.caption)
          .padding(.horizontal)
      }
    }
  }
}

#Preview {
  CommentsView()
}

