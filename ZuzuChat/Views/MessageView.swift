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

struct MessageView: View {
  var article: NewsResponse
  
  @State private var messages: [Message] = [
    Message(text: "Hello, good morning", isSent: false, time: "09:11"),
    Message(text: "I am a Customer Service. Is there anything I can help you with? 😊", isSent: false, time: "09:15"),
    Message(text: "Hi, I'm having problems with my order & payment", isSent: true, time: "09:16"),
    Message(text: "Can you help me?", isSent: true, time: "09:24"),
    Message(text: "Of course..", isSent: false, time: "09:31"),
    Message(text: "Can you tell me the problem you are having? So I can help solve it 😊", isSent: false, time: "09:45")
  ]
  @State private var newMessage: String = ""
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 5) {
        BackButton()
        
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
              withAnimation {
                scrollView.scrollTo(messages.last?.id, anchor: .bottom)
              }
            })
          }
          
          ChatInputView(newMessage: $newMessage) {
            sendMessage()
          }
        }
      }
      .foregroundStyle(.white)
      .overlay(alignment: .top) {
        HStack {
          Text(article.sourceName)
            .font(.headline.bold().monospaced())
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
        }
      }
    }
  }
}

private extension MessageView {
  func sendMessage() {
    guard !newMessage.isEmpty else { return }
    let message = Message(text: newMessage, isSent: true, time: Date.now.formatted(date: .omitted, time: .shortened))
    messages.append(message)
    newMessage = ""
  }
}

struct MessageBubble: View {
  let message: Message
  
  var body: some View {
    HStack {
      if message.isSent { Spacer() }
      
      VStack(alignment: message.isSent ? .trailing : .leading, spacing: 4) {
        Text(message.text)
          .padding()
          .background(message.isSent ? Color(.pink).opacity(0.3) : Color.gray.opacity(0.2))
          .foregroundColor(.white)
          .cornerRadius(20)
        
        Text(message.time)
          .font(.caption)
          .foregroundColor(.gray)
          .padding(message.isSent ? .trailing : .leading, 10)
          .frame(maxWidth: .infinity, alignment: message.isSent ? .trailing : .leading)
      }
      .frame(maxWidth: 300, alignment: message.isSent ? .trailing : .leading)
    }
    .padding(.horizontal)
  }
}

struct ChatInputView: View {
  @Binding var newMessage: String
  var onSend: () -> Void
  
  var body: some View {
    HStack {
      TextField("", text: $newMessage, prompt: Text("Messages...").foregroundStyle(.gray))
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .foregroundColor(.white)
      
      Button { onSend() } label: {
        Image(systemName: "paperplane.fill")
          .foregroundColor(.white)
          .padding()
          .background(Color(.pink))
          .clipShape(Circle())
      }
    }
    .padding([.horizontal, .bottom])
  }
}

#Preview {
  MessageView(article: NewsResponse.init())
}
