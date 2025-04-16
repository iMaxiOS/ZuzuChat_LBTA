//
//  ChatViewModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Observation

@Observable
final class ChatViewModel {
  var messages: [MessageResponse] = []
  
  func fetchMessages() {
      Task {
        do {
          messages = try await NetworkManager.shared.fetchMessages()
        } catch {
          print("Failed to fetch articles:", error)
        }
      }
  }
}
