//
//  HomeView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI
import Observation


struct HomeView: View {
  @EnvironmentObject var session: SessionManager
  
  @State private var selectedTab: Int = 0
  
  @Binding var offsetShare: CGFloat
  @Binding var offsetComment: CGFloat
  
  var body: some View {
    ZStack {
      Color.bg
      
      SwipableImageView()
      
      TopTabBar(selectedTab: $selectedTab)
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 60)
      
      HStack(alignment: .bottom, spacing: 10) {
        BottomInformationView()
          .environmentObject(session)
        Spacer()
        BottomButtonsView(offsetShare: $offsetShare, offsetComment: $offsetComment)
          .environmentObject(session)
      }
      .frame(maxHeight: .infinity, alignment: .bottom)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(width: UIScreen.main.bounds.width)
      .padding(.bottom, 100)
    }
    .ignoresSafeArea()
  }
}

struct BottomButtonsView: View {
  @EnvironmentObject var session: SessionManager
  
  @Binding var offsetShare: CGFloat
  @Binding var offsetComment: CGFloat
  
  var body: some View {
    VStack(spacing: 25) {
      Button {
        session.navigate(to: .report)
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
          offsetComment = 0
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
          offsetShare = 0
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
  @EnvironmentObject var session: SessionManager
  
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
    HStack(spacing: 16) {
      Button {} label: {
        Image(systemName: "play.tv.fill")
          .renderingMode(.template)
          .foregroundStyle(.white)
          .imageScale(.large)
          .padding(10)
        
      }
      
      Spacer(minLength: 3)
      
      HStack(spacing: 10) {
        ForEach(tabs.indices, id: \..self) { index in
          Button {
            selectedTab = index
          } label: {
            VStack {
              Text(tabs[index])
                .font(.system(size: 16, weight: .medium))
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
        }
      }
      
      Spacer(minLength: 3)
      
      Button {} label: {
        Image(systemName: "sparkle.magnifyingglass")
          .renderingMode(.template)
          .foregroundStyle(.white)
          .imageScale(.large)
          .padding(10)
      }
    }
    .padding(.horizontal, 10)
    .buttonStyle(.plain)
  }
}

struct SwipableImageView: View {
  let images: [String] = ["thor", "scarlet", "panther"]
  
  var body: some View {
    TabView {
      ForEach(images, id: \..self) { imageName in
        Image(imageName)
          .resizable()
          .scaledToFill()
          .rotationEffect(.degrees(-90))
          .clipped()
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    .rotationEffect(.degrees(90))
    .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
  }
}


#Preview {
  HomeView(offsetShare: .constant(0), offsetComment: .constant(0))
    .environmentObject(SessionManager())
}
