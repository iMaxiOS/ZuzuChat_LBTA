//
//  ZuzuChatApp.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

@main
struct ZuzuChatApp: App {
  @State private var session = SessionManager()
  
  var body: some Scene {
    WindowGroup {
      Group {
        if session.isAuthorized {
          TabbarView()
            .environment(session)
        } else {
          OnboardingView()
//            .environment(session)
        }
      }
    }
  }
}
