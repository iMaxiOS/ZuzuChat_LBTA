//
//  Tabbar.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI

struct TabbarView: View {
  @Environment(SessionManager.self) private var session
  
  @State private var selectedTab: TabbarType = .home
  
  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        HomeView()
          .withAppRouter()
          .tabItem {
            Label(TabbarType.home.name, systemImage: TabbarType.home.image)
          }
        
        ExploreView()
          .navigationTitle(TabbarType.explore.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.explore.name, systemImage: TabbarType.explore.image)
          }
        
        CallListView()
          .navigationTitle(TabbarType.phone.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.phone.name, systemImage: TabbarType.phone.image)
          }
        
        ChatView()
          .navigationTitle(TabbarType.chat.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.chat.name, systemImage: TabbarType.chat.image)
          }
        
        ProfileView()
          .navigationTitle(TabbarType.profile.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.profile.name, systemImage: TabbarType.profile.image)
          }
      }
    }
  }
}

#Preview {
  TabbarView()
    .environment(SessionManager())
}
