//
//  ExploreViewModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Observation

@Observable
final class ExploreViewModel {
  var articles: [NewsResponse] = []
  
  func fetchArticles() {
      Task {
        do {
          articles = try await NetworkManager.shared.fetchPoliticsNews()
        } catch {
          print("Failed to fetch articles:", error)
        }
      }
  }
}
