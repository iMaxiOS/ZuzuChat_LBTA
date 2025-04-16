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
    .init(photo: "thor", name: "Kristian Thor", comment: "Here's a SwiftUI implementation of the screen you provided, targeting iOS 17. This layout includes", like: "544", ago: "5 days ago"),
    .init(photo: "panther", name: "Maxim Mashilhin", comment: "Here's a SwiftUI implementation of the screen you provided, targeting iOS 17. This layout includes", like: "322", ago: "2 days ago"),
    .init(photo: "scarlet", name: "David Karlson", comment: "Here's a SwiftUI implementation of the screen you provided, targeting iOS 17. This layout includes", like: "544", ago: "1 days ago")
  ]
}

struct CommentsView: View {
  @Binding var offsetY: CGFloat
  
  private let commentsMock = CommentItem.comments
  
  @State private var addCommentText: String = ""
  
  var body: some View {
    VStack(alignment: .leading, spacing: 25) {
      VStack(spacing: 20) {
        RoundedRectangle(cornerRadius: 2)
          .fill(Color.gray.opacity(0.4))
          .frame(width: 40, height: 4)
        
        Text("22K Comments")
          .font(.title2.bold().monospaced())
      }
      .frame(maxWidth: .infinity, alignment: .center)
      
      RoundedRectangle(cornerRadius: 0.5)
        .fill(.gray.opacity(0.4))
        .frame(height: 1)
      
      ForEach(commentsMock) { mock in
        item(mock)
      }
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
          .foregroundStyle(.white)
        
        Spacer()
        
        Button {} label: {
          Image(systemName: "circle.grid.3x3.circle")
            .padding(.vertical)
        }
        .buttonStyle(.plain)
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
    .foregroundStyle(.gray)
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
  CommentsView(offsetY: .constant(70))
}
