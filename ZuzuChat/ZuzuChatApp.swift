//
//  ZuzuChatApp.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

@main
struct ZuzuChatApp: App {
  @StateObject private var session: SessionManager = SessionManager()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $session.navigatePath) {
        Group {
          if session.isAuthorized {
            MainView()
              .environmentObject(session)
          } else {
            OnboardingView()
              .environmentObject(session)
          }
        }
        .withAppRouter(session: session)
      }
    }
  }
}
