//
//  LoginView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

struct LoginView: View {
  @Environment(AppRouterManager.self) private var router
  @Environment(SessionManager.self) private var session
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg
        .ignoresSafeArea()
      
      VStack(spacing: 20) {
        Image(.illustration1)
          .resizable()
        
        Text("Let`s you in")
          .font(.largeTitle.bold().monospaced())
        
        VStack {
          Button {
            
          } label: {
            HStack(spacing: 10) {
              Image(.facebook)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
              Text("Continue with facebook")
                .font(.subheadline.bold().monospaced())
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.grayBlue)
            .clipShape(.rect(cornerRadius: 20))
            .overlay {
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
          }
          Button {
            
          } label: {
            HStack(spacing: 10) {
              Image(.google)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
              Text("Continue with google")
                .font(.subheadline.bold().monospaced())
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.grayBlue)
            .clipShape(.rect(cornerRadius: 20))
            .overlay {
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
          }
          Button {
            
          } label: {
            HStack(spacing: 10) {
              Image(systemName: "apple.logo")
                .resizable()
                .frame(width: 18, height: 20)
              Text("Continue with apple")
                .font(.subheadline.bold().monospaced())
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.grayBlue)
            .clipShape(.rect(cornerRadius: 20))
            .overlay {
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
          }
        }
        .padding(.horizontal, 10)
        
        HStack(spacing: 15) {
          RoundedRectangle(cornerRadius: 1)
            .frame(height: 1)
            .foregroundStyle(.white.opacity(0.1))
            .padding(.leading, 20)
          
          Text("or")
            .font(.subheadline.bold().monospaced())
          
          RoundedRectangle(cornerRadius: 1)
            .frame(height: 1)
            .foregroundStyle(.white.opacity(0.1))
            .padding(.trailing, 20)
        }
        .padding(.vertical, 10)
        
        VStack(spacing: 5 ) {
          Button {
            router.push(AppRouterType.signIn)
          } label: {
            Text("Sign in with password")
              .font(.subheadline.bold().monospaced())
              .frame(height: 50)
              .frame(maxWidth: .infinity)
              .background(Color(.pink))
              .clipShape(.rect(cornerRadius: 50))
          }
          
          Button {
            router.push(AppRouterType.signUp)
          } label: {
            HStack {
              Text("Don`t have an account?")
              Text("Sign up")
                .foregroundStyle(Color(.pink))
            }
            .font(.caption.bold().monospaced())
            .frame(height: 50)
            .frame(maxWidth: .infinity)
          }
        }
        .padding(.horizontal, 10)
      }
      .buttonStyle(.plain)
    }
    .foregroundStyle(.white)
  }
}

#Preview {
  LoginView()
    .environment(SessionManager())
    .environment(AppRouterManager())
}
