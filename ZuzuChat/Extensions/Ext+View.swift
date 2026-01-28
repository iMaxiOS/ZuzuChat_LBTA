//
//  Ext+View.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

enum AppRouterType: Hashable {
  case report
  case message(article: NewsResponse)
  case explore(new: NewsResponse)
}

struct AppRouterModifier: ViewModifier {
  @Environment(SessionManager.self) private var session
  @State private var router = AppRouterManager()
  
  func body(content: Content) -> some View {
    NavigationStack(path: $router.path) {
      content
        .environment(router)
        .navigationDestination(for: AppRouterType.self) { destination in
          switch destination {
          case .report:
            ReportView()
              .environment(session)
              .environment(router)
          case .message(let article):
            MessageDetailView(article: article)
              .environment(session)
              .environment(router)
          case .explore(let new):
            ExploreDetailView(new: new)
              .environment(session)
              .environment(router)
          }
        }
    }
  }
}

extension View {
  func withAppRouter() -> some View {
    modifier(AppRouterModifier())
  }
}
