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
  @State private var offsetComment: CGFloat = UIScreen.main.bounds.height
  @State private var offsetShare: CGFloat = UIScreen.main.bounds.height
  @State private var isShowCallView: Bool = false
  
  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        HomeView(session: session)
//          .tag(TabbarType.home)
//          .environment(session)
//          .toolbarVisibility(.hidden, for: .tabBar)
          .tabItem {
            Label(TabbarType.home.name, systemImage: TabbarType.home.image)
          }
        
        ExploreView(session: session)
//          .tag(TabbarType.explore)
//          .environment(session)
//          .toolbarVisibility(.hidden, for: .tabBar)
          .tabItem {
            Label(TabbarType.explore.name, systemImage: TabbarType.explore.image)
          }
        
        CallView()
//          .environment(session)
          .tabItem {
            Label(TabbarType.phone.name, systemImage: TabbarType.phone.image)
          }
        
        
        ChatView(session: session)
//          .tag(TabbarType.chat)
//          .environment(session)
//          .toolbarVisibility(.hidden, for: .tabBar)
          .tabItem {
            Label(TabbarType.chat.name, systemImage: TabbarType.chat.image)
          }
        
        ProfileView(session: session)
//          .tag(TabbarType.profile)
//          .environment(session)
//          .toolbarVisibility(.hidden, for: .tabBar)
          .tabItem {
            Label(TabbarType.profile.name, systemImage: TabbarType.profile.image)
          }
      }
      
//      HStack {
//        ForEach(TabbarType.allCases, id: \.rawValue) { tab in
//          Button {
//            if tab == .phone {
//              isShowCallView.toggle()
//            } else {
//              selectedTab = tab
//            }
//          } label: {
//            if tab == .phone {
//              Circle()
//                .fill(Color(.pink))
//                .frame(width: 40, height: 40)
//                .overlay {
//                  Image(systemName: tab.unSelectedImage)
//                }
//                .padding(.horizontal, 10)
//            } else {
//              VStack(spacing: 3) {
//                Image(systemName: selectedTab == tab ? tab.image : tab.unSelectedImage)
//                Text(tab.name)
//                  .font(.footnote)
//              }
//              .padding(.vertical, 10)
//              .frame(width: 70)
//              .foregroundStyle(selectedTab == tab ? Color(.pink) : .gray)
//            }
//          }
//          .buttonStyle(.plain)
//        }
//        .padding(.bottom, 20)
//      }
//      .frame(height: 82)
//      .frame(maxWidth: UIScreen.main.bounds.width)
//      .background(.bg.opacity(0.7))
//      .background(.ultraThinMaterial)
//      .clipShape(.rect(topLeadingRadius: 25, topTrailingRadius: 25))
//      .frame(maxHeight: .infinity, alignment: .bottom)
//      .offset(y: session.navigatePath.isEmpty ? 0 : 100)
//      .animation(
//        .spring(response: 0.4, dampingFraction: 0.9), value: session.navigatePath.isEmpty
//      )
      
//      if offsetComment == 0 || offsetShare == 0 {
//        VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
//      }
//      
//      ShareView(offsetY: $offsetShare)
//        .frame(maxHeight: .infinity, alignment: .bottom)
//      
//      CommentsView(offsetY: $offsetComment)
//        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    .ignoresSafeArea()
//    .fullScreenCover(isPresented: $isShowCallView) {
//      CallView()
//        .environmentObject(session)
//        .toolbarVisibility(.hidden, for: .tabBar)
//    }
  }
}

#Preview {
  TabbarView(session: .init())
    .environment(SessionManager())
}
