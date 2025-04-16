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
  @EnvironmentObject var session: SessionManager
  
  @State private var selectedType: ForgetPasswordType = .none
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          BackButton()
          
          Text("Forget Password")
            .font(.headline.bold().monospaced())
        }
        
        Image(.illustration1)
          .resizable()
        
        Text("Select which contact details should we use to reset your password")
          .font(.footnote.bold().monospaced())
          .padding(.horizontal, 20)
        
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
                .padding(.horizontal, 20)
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
                .padding(.horizontal, 20)
              }
              .frame(height: 125)
              .overlay {
                RoundedRectangle(cornerRadius: 25)
                  .stroke(selectedType == .email ? Color(.pink).opacity(0.7) : .clear, lineWidth: 2)
              }
          }
        }
        .padding(.horizontal, 20)
        
        Spacer()
        
        Button {
          session.navigate(to: .pinOrForget(type: .forgetPassword))
        } label: {
          Text("Continue")
            .font(.headline.bold().monospaced())
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(Color(.pink)))
            .clipShape(.rect(cornerRadius: 50))
        }
        .padding(.horizontal, 20)
        .disabled(selectedType == .none)
      }
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
  }
}

#Preview {
    ForgetPasswordView()
}
