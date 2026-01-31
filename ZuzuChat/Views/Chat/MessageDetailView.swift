//
//  ChatScreenView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//


import SwiftUI

struct Message: Identifiable {
  let id = UUID()
  let text: String
  let isSent: Bool
  let time: String
}

struct MessageDetailView: View {
  var article: NewsResponse
  
  @State private var newMessage: String = ""
  @State private var messages: [Message] = [
    Message(text: "Hello, good morning", isSent: false, time: "09:11"),
    Message(text: "I am a Customer Service. Is there anything I can help you with? 😊", isSent: false, time: "09:15"),
    Message(text: "Hi, I'm having problems with my order & payment", isSent: true, time: "09:16"),
    Message(text: "Can you help me?", isSent: true, time: "09:24"),
    Message(text: "Of course..", isSent: false, time: "09:31"),
    Message(text: "Can you tell me the problem you are having? So I can help solve it 😊", isSent: false, time: "09:45")
  ]
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      content
    }
    .navigationTitle(Text(article.sourceName))
    .navigationBarTitleDisplayMode(.inline)
    .toolbarVisibility(.hidden, for: .tabBar)
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        TextField("", text: $newMessage, prompt: Text("Messages...").foregroundStyle(.gray))
          .padding(10)
          .lineLimit(1...4)
      }
      
      ToolbarSpacer(.fixed, placement: .bottomBar)
      
      ToolbarItem(placement: .bottomBar) {
        Button { sendMessage() } label: {
          Image(systemName: "paperplane.fill")
        }
        .padding(2)
        .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
      }
    }
  }
}

private extension MessageDetailView {
  var content: some View {
    VStack {
      ScrollViewReader { scrollView in
        ScrollView {
          VStack(alignment: .leading, spacing: 10) {
            ForEach(messages) { message in
              MessageBubble(message: message)
            }
          }
        }
        .onChange(of: messages.count, { oldValue, newValue in
          if let lastID = messages.last?.id {
            withAnimation {
              scrollView.scrollTo(lastID, anchor: .bottom)
            }
          }
        })
      }
    }
  }
  
  func sendMessage() {
    guard !newMessage.isEmpty else { return }
    let message = Message(text: newMessage, isSent: true, time: Date.now.formatted(date: .omitted, time: .shortened))
    messages.append(message)
    newMessage = ""
  }
}

#Preview {
  MessageDetailView(article: NewsResponse.init())
}
