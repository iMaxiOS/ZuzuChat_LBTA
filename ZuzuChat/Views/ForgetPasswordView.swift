//
//  ForgetPasswordView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI

enum ForgetPasswordType {
  case none, sms, email
}

struct ForgetPasswordView: View {
  @Bindable var session: SessionManager
  @Environment(AppRouterManager.self) private var router
  
  @State private var selectedType: ForgetPasswordType = .none
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        Image(.illustration1)
          .resizable()
        
        Text("Select which contact details should we use to reset your password")
          .font(.footnote.bold().monospaced())
          .padding(.horizontal, 10)
        
        VStack(alignment: .leading, spacing: 16) {
          Button {
            selectedType = .sms
          } label: {
            RoundedRectangle(cornerRadius: 30)
              .fill(.grayBlue)
              .overlay {
                HStack(spacing: 15) {
                  Image(systemName: "ellipsis.message.fill")
                    .foregroundStyle(.pink)
                    .imageScale(.large)
                    .padding(30)
                    .background(Color(.pink).opacity(0.2))
                    .clipShape(.circle)
                  
                  VStack(alignment: .leading) {
                    Text("via SMS:")
                      .font(.caption)
                    Text("+1 111 ......99")
                      .font(.headline.bold())
                  }
                  
                  Spacer()
                }
                .padding(.horizontal, 10)
              }
              .frame(height: 125)
              .overlay {
                RoundedRectangle(cornerRadius: 25)
                  .stroke(selectedType == .sms ? Color(.pink).opacity(0.7) : .clear, lineWidth: 2)
              }
          }
          
          Button {
            selectedType = .email
          } label: {
            RoundedRectangle(cornerRadius: 30)
              .fill(.grayBlue)
              .overlay {
                HStack(spacing: 15) {
                  Image(systemName: "envelope.open.fill")
                    .foregroundStyle(.pink)
                    .imageScale(.large)
                    .padding(30)
                    .background(Color(.pink).opacity(0.2))
                    .clipShape(.circle)
                  
                  VStack(alignment: .leading) {
                    Text("via Email:")
                      .font(.caption)
                    Text("and....ley@gmail.com")
                      .font(.headline.bold())
                  }
                  
                  Spacer()
                }
                .padding(.horizontal, 10)
              }
              .frame(height: 125)
              .overlay {
                RoundedRectangle(cornerRadius: 25)
                  .stroke(selectedType == .email ? Color(.pink).opacity(0.7) : .clear, lineWidth: 2)
              }
          }
        }
        
        Spacer()
        
        Button {
          router.push(AppRouterType.pinOrForget(type: .forgetPassword))
        } label: {
          Text("Continue")
            .font(.headline.bold().monospaced())
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(Color(.pink)))
            .clipShape(.rect(cornerRadius: 50))
        }
        .disabled(selectedType == .none)
      }
      .padding(.horizontal, 10)
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
    .navigationTitle(Text("Forget Password"))
  }
}

#Preview {
  NavigationStack {
    ForgetPasswordView(session: .init())
      .environment(SessionManager())
      .navigationBarTitleDisplayMode(.inline)
  }
}
