//
//  Tabbar.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI

struct TabbarView: View {
  @Environment(SessionManager.self) private var session
  @Environment(AppRouterManager.self) private var router
  
  var body: some View {
    ZStack {
      TabView(selection: Bindable(router).selectedTab) {
        HomeView()
          .withAppRouter()
          .tabItem {
            Label(TabbarType.home.name, systemImage: TabbarType.home.image)
          }
          .tag(TabbarType.home)
        
        ExploreView()
          .navigationTitle(TabbarType.explore.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.explore.name, systemImage: TabbarType.explore.image)
          }
          .tag(TabbarType.explore)
        
        CallListView()
          .navigationTitle(TabbarType.phone.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.phone.name, systemImage: TabbarType.phone.image)
          }
          .tag(TabbarType.phone)
        
        ChatView()
          .navigationTitle(TabbarType.chat.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.chat.name, systemImage: TabbarType.chat.image)
          }
          .tag(TabbarType.chat)
        
        ProfileView()
          .navigationTitle(TabbarType.profile.name)
          .withAppRouter()
          .tabItem {
            Label(TabbarType.profile.name, systemImage: TabbarType.profile.image)
          }
          .tag(TabbarType.profile)
      }
    }
  }
}

#Preview {
  TabbarView()
    .environment(SessionManager())
    .environment(AppRouterManager())
}
