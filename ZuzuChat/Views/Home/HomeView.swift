//
//  HomeView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI

struct HomeView: View {
  @Environment(SessionManager.self) private var session
  @Environment(AppRouterManager.self) private var router
  
  @State private var vm = HomeViewModel()
  @State private var isShowShare: Bool = false
  @State private var isShowComments: Bool = false
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      SwappableImageView()
      
      HStack(alignment: .bottom, spacing: 10) {
        BottomInformationView()
          .environment(session)
        
        Spacer()
        
        BottomButtonsView(
          isLike: $vm.isLike,
          isShowComments: $isShowComments,
          isShowShare: $isShowShare
        )
          .environment(session)
          .environment(router)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      .padding(.bottom)
    }
    .sheet(isPresented: $isShowComments) {
      CommentsView()
    }
    .sheet(isPresented: $isShowShare) {
      ShareView()
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {} label: {
          Image(systemName: "sparkle.magnifyingglass")
            .foregroundStyle(.secondary)
            .imageScale(.large)
        }
      }
      
      ToolbarItem(placement: .title) {
        TopTabBar(selectedTab: $vm.selectedTab)
      }
      
      ToolbarItem(placement: .topBarLeading) {
        Button {} label: {
          Image(systemName: "play.tv.fill")
            .foregroundStyle(.secondary)
            .imageScale(.large)
        }
      }
    } 
  }
}

struct TopTabBar: View {
  @Binding var selectedTab: Int
  
  private let tabs = ["Following", "Friends", "For You"]
  
  var body: some View {
    HStack(spacing: 10) {
      ForEach(tabs.indices, id: \.self) { index in
        Button {
          selectedTab = index
        } label: {
          VStack {
            Text(tabs[index])
              .font(.system(size: 15, weight: .medium))
              .foregroundColor(selectedTab == index ? Color(.pink) : .white)
              .overlay(alignment: .bottom) {
                Rectangle()
                  .frame(height: 2)
                  .foregroundColor(selectedTab == index ? Color(.pink) : .white)
                  .animation(.easeInOut, value: selectedTab)
                  .offset(y: 5)
              }
          }
        }
        .padding(.vertical, 10)
      }
    }
  }
}

#Preview {
  HomeView()
    .environment(SessionManager())
    .environment(AppRouterManager())
}
