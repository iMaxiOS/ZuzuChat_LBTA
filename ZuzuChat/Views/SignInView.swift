//
//  SignInView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI

struct SignInView: View {
  @EnvironmentObject var session: SessionManager
  
  @State private var vm = SignInViewModel()
  
  @State private var isCheckCredentials: Bool = false
  
  private var textType: Bool = true
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg
        .ignoresSafeArea()
      
      BackButton()
      
      VStack(alignment: .leading, spacing: 20) {
        Text("Login to your\nAccount")
          .font(.largeTitle.bold().monospaced())
          .padding(.bottom, 60)
          .padding(.top, 100)
        
        VStack(spacing: 12) {
          CustomTextField(text: $vm.email, textFieldType: false)
            .background(isCheckCredentials ? Color(.pink.opacity(0.1)) : Color.grayBlue)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(isCheckCredentials ? Color(.pink) : Color.clear, lineWidth: 1)
            )
          CustomTextField(text: $vm.password, textFieldType: true)
            .background(isCheckCredentials ? Color(.pink.opacity(0.1)) : Color.grayBlue)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(isCheckCredentials ? Color(.pink) : Color.clear, lineWidth: 1)
            )
          
          HStack(spacing: 10) {
            Button {
              session.isAuthorized.toggle()
            } label: {
              HStack {
                Image(systemName: session.isAuthorized ? "checkmark.square.fill" : "square")
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 20, height: 20)
                  .foregroundStyle(Color(.pink))
                
                Text("Remember me")
                  .font(.footnote.bold().monospaced())
                  .padding(.vertical, 5)
              }
            }
            .buttonStyle(.plain)
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .padding(.vertical, 10)
          
          Button {
              let isValid = vm.checkingCredentials()
              isCheckCredentials = !isValid
              
              if isValid {
                session.user.email = vm.email
                session.user.password = vm.password
                session.navigate(to: .chooseInterest)
              }
          } label: {
            Text("Sign In")
              .font(.subheadline.bold().monospaced())
              .frame(height: 50)
              .frame(maxWidth: .infinity)
              .background(Color(.pink))
              .clipShape(.rect(cornerRadius: 50))
          }
          .disabled(vm.email.isEmpty || vm.password.isEmpty)
          
          Button {
            session.navigate(to: .forgotPassword)
          } label: {
            HStack {
              Text("Forgot the password?")
                .foregroundStyle(Color(.pink))
            }
            .font(.footnote.bold().monospaced())
            .frame(height: 50)
            .frame(maxWidth: .infinity)
          }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
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
        .padding(.top, 60)
      }
      .padding(.horizontal, 20)
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
}

#Preview {
  SignInView()
    .environmentObject(SessionManager())
}
