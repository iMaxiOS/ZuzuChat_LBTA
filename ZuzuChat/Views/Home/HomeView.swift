//
//  HomeView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI

struct HomeView: View {
  @Bindable var session: SessionManager
  
  @State private var selectedTab: Int = 0
  
  //  @Binding var offsetShare: CGFloat
  //  @Binding var offsetComment: CGFloat
  
  var body: some View {
    ZStack {
      Color.bg
        .ignoresSafeArea()
      
      SwappableImageView()
      
      TopTabBar(selectedTab: $selectedTab)
      
      HStack(alignment: .bottom, spacing: 10) {
        BottomInformationView(session: session)
        Spacer()
        BottomButtonsView(session: session)
      }
      .frame(maxHeight: .infinity, alignment: .bottom)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.bottom)
    }
  }
}

struct BottomButtonsView: View {
  @Bindable var session: SessionManager
  @Environment(AppRouterManager.self) private var router
  
  var body: some View {
    VStack(spacing: 25) {
      Button {
        router.push(AppRouterType.report)
      } label: {
        Image(systemName: "flag.fill")
          .resizable()
          .frame(width: 25, height: 25)
      }
      .padding()
      
      Button {} label: {
        VStack(spacing: 10) {
          Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 30, height: 25)
            .foregroundStyle(Color(.pink))
          Text("225.9K")
            .font(.footnote)
        }
      }
      Button {
        withAnimation(.spring) {
          //          offsetComment = 0
        }
      } label: {
        VStack(spacing: 10) {
          Image(systemName: "message.fill")
            .resizable()
            .frame(width: 30, height: 25)
          Text("22K")
            .font(.footnote)
        }
      }
      Button {
        withAnimation(.spring) {
          //          offsetShare = 0
        }
      } label: {
        VStack(spacing: 10) {
          Image(systemName: "paperplane.fill")
            .resizable()
            .frame(width: 30, height: 25)
          Text("20.7K")
            .font(.footnote)
        }
      }
    }
    .buttonStyle(.plain)
    .foregroundStyle(.white)
    .padding(.trailing, 10)
  }
}

struct BottomInformationView: View {
  @Bindable var session: SessionManager
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Image(uiImage: base64ToImage(session.user.avatar ??  "") ?? UIImage())
          .resizable()
          .scaledToFill()
          .frame(width: 55, height: 55)
          .clipShape(.circle)
        
        VStack(alignment: .leading, spacing: 10) {
          Text((session.user.fullName ?? "") + " " + (session.user.nickname ?? ""))
            .font(.headline.bold().monospaced())
            .foregroundStyle(.white)
          Text("Actor & Singer")
            .foregroundStyle(.gray)
            .font(.footnote.italic())
        }
      }
      
      Text("Hi everyone in this video i will sing o song\n&song &music &love &beauty")
        .font(.footnote.bold())
      
      HStack {
        Image(systemName: "music.note")
        Text("Following Girl by \(session.user.nickname ?? "")")
          .font(.caption.bold().monospaced())
      }
    }
    .foregroundStyle(.gray)
    .padding(.horizontal)
  }
}

struct TopTabBar: View {
  @Binding var selectedTab: Int
  
  private let tabs = ["Following", "Friends", "For You"]
  
  var body: some View {
    HStack(spacing: 0) {
      Button {} label: {
        Image(systemName: "play.tv.fill")
          .foregroundStyle(.secondary)
          .imageScale(.large)
          .padding(10)
      }
      .glassEffect(.clear, in: .capsule)
      
      Spacer()
      
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
          .padding(.horizontal, 3)
        }
      }
      .padding(.horizontal, 13)
      .glassEffect(.clear, in: .capsule)
      
      Spacer()
      
      Button {} label: {
        Image(systemName: "sparkle.magnifyingglass")
          .foregroundStyle(.secondary)
          .imageScale(.large)
          .padding(10)
      }
      .glassEffect(.clear, in: .capsule)
    }
    .padding(.horizontal)
    .frame(maxHeight: .infinity, alignment: .top)
  }
}

struct SwappableImageView: View {
  private let images: [String] = ["scarlet", "thor", "panther"]
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(images, id: \..self) { imageName in
          Image(imageName)
            .resizable()
            .scaledToFill()
            .containerRelativeFrame(.vertical)
            .scrollTargetLayout()
        }
      }
    }
    .scrollTargetBehavior(.paging)
    .ignoresSafeArea()
  }
}


#Preview {
  HomeView(session: .init())
    .environment(SessionManager())
}
