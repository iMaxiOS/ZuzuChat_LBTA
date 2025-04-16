//
//  CreateAccountView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

struct SignUpView: View {
  @EnvironmentObject var session: SessionManager
  
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var isSecureTextEntry: Bool = true
  @State private var isRememberMe: Bool = false
  @State private var isCheckCredentials: Bool = false
  
  private var textType: Bool = true
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg
        .ignoresSafeArea()
      
      BackButton()
      
      VStack(alignment: .leading, spacing: 20) {
        Spacer()
        
        Text("Create your Account")
          .font(.largeTitle.bold().monospaced())
          .padding(.bottom, 60)
        
        VStack(spacing: 15) {
          CustomTextField(text: $email, textFieldType: false)
            .background(isCheckCredentials ? Color(.pink.opacity(0.5)) : Color.grayBlue)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(isCheckCredentials ? Color(.pink) : Color.clear, lineWidth: 1)
            )
          CustomTextField(text: $password, textFieldType: true)
            .background(isCheckCredentials ? Color(.pink.opacity(0.5)) : Color.grayBlue)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(isCheckCredentials ? Color(.pink) : Color.clear, lineWidth: 1)
            )
          
          HStack(spacing: 10) {
            Button {
              isRememberMe.toggle()
            } label: {
              Image(systemName: isRememberMe ? "square" : "checkmark.square.fill")
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundStyle(Color(.pink))
            }
            .buttonStyle(.plain)
            
            Text("Remember me")
              .font(.footnote.bold().monospaced())
              .padding(.vertical, 5)
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .padding(.vertical, 10)
          
          Button {
            
          } label: {
            Text("Sign up")
              .font(.subheadline.bold().monospaced())
              .frame(height: 50)
              .frame(maxWidth: .infinity)
              .background(Color(.pink))
              .clipShape(.rect(cornerRadius: 50))
          }
        }
        
        VStack(spacing: 15) {
          HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 1)
              .frame(height: 1)
              .foregroundStyle(.white.opacity(0.1))
            
            
            Text("or continue with")
              .font(.footnote.monospaced())
              .layoutPriority(1)
            
            RoundedRectangle(cornerRadius: 1)
              .frame(height: 1)
              .foregroundStyle(.white.opacity(0.1))
          }
          .padding(.vertical, 10)
          
          HStack(spacing: 20) {
            Button {
              
            } label: {
              Image(.facebook)
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
                .padding(.vertical)
                .padding(.horizontal, 25)
                .background(.grayBlue)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                  RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
                }
            }
            
            Button {
              
            } label: {
              Image(.google)
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
                .padding(.vertical)
                .padding(.horizontal, 25)
                .background(.grayBlue)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                  RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
                }
            }
            
            Button {
              
            } label: {
              Image(systemName: "apple.logo")
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
                .padding(.vertical)
                .padding(.horizontal, 25)
                .background(.grayBlue)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                  RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
                }
            }
          }
          .foregroundStyle(.white)
          .padding(.bottom)
        }
        .padding(.top, 120)
      }
      .padding(.horizontal, 20)
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
  }
}

#Preview {
  SignUpView()
    .environmentObject(SessionManager())
}
