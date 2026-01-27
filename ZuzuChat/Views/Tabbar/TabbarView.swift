//
//  Tabbar.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI

struct TabbarView: View {
  @Bindable var session: SessionManager
  
  @State private var selectedTab: TabbarType = .home
  
  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        NavigationStack {
          HomeView(session: session)
            .withAppRouter()
        }
        .tabItem {
          Label(TabbarType.home.name, systemImage: TabbarType.home.image)
        }
        
        NavigationStack() {
          ExploreView(session: session)
            .navigationTitle(TabbarType.explore.name)
            .withAppRouter()
        }
        .tabItem {
          Label(TabbarType.explore.name, systemImage: TabbarType.explore.image)
        }
        
        NavigationStack() {
          CallListView()
            .navigationTitle(TabbarType.phone.name)
            .withAppRouter()
        }
        .tabItem {
          Label(TabbarType.phone.name, systemImage: TabbarType.phone.image)
        }
        
        NavigationStack() {
          ChatView(session: session)
            .navigationTitle(TabbarType.chat.name)
            .withAppRouter()
        }
        .tabItem {
          Label(TabbarType.chat.name, systemImage: TabbarType.chat.image)
        }
        
        NavigationStack() {
          ProfileView(session: session)
            .navigationTitle(TabbarType.profile.name)
            .withAppRouter()
        }
        .tabItem {
          Label(TabbarType.profile.name, systemImage: TabbarType.profile.image)
        }
      }
    }
  }
}

#Preview {
  TabbarView(session: .init())
    .environment(SessionManager())
}
