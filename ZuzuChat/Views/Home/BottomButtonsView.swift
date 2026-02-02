//
//  BottomButtonsView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI

struct BottomButtonsView: View {
  @Environment(SessionManager.self) private var session
  @Environment(AppRouterManager.self) private var router
  
  @Binding var isLike: Bool
  @Binding var isShowComments: Bool
  @Binding var isShowShare: Bool
  
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
      
      Button {
        withAnimation(.spring) {
          isLike.toggle()
        }
      } label: {
        VStack(spacing: 10) {
          Image(systemName: isLike ? "heart.fill" : "heart")
            .resizable()
            .frame(width: 30, height: 25)
            .foregroundStyle(Color(.pink))
          Text("225.9K")
            .font(.footnote)
        }
      }
      Button {
        withAnimation(.spring) {
          isShowComments.toggle()
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
          isShowShare.toggle()
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
