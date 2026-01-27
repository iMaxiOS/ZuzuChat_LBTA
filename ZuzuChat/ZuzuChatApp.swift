//
//  ZuzuChatApp.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

@main
struct ZuzuChatApp: App {
  @State private var session: SessionManager = SessionManager()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $session.navigatePath) {
        Group {
          if session.isAuthorized {
            TabbarView(session: session)
//              .environment(session)
          } else {
            OnboardingView(session: session)
//              .environment(session)
          }
        }
        .withAppRouter(session: session)
      }
    }
  }
}
