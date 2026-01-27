//
//  ExploreViewModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Observation

@MainActor @Observable
final class ExploreViewModel {
  var articles: [NewsResponse] = []
  var isSearching: Bool = false
  var searchText: String = ""
  
  private var searchTask: Task<Void, Never>?
  
  func fetchArticles() async {
    do {
      articles = try await NetworkManager.shared.fetchPoliticsNews()
    } catch {
      print("Failed to fetch articles:", error)
    }
  }
  
  func searchArticles(query: String) {
    searchTask?.cancel()
    searchTask = Task {
      try? await Task.sleep(nanoseconds: 500_000_000)

      do {
        articles = try await NetworkManager.shared.searchNews(query: query)
      } catch {
        print("Failed to fetch articles:", error)
      }
    }
  }
}
