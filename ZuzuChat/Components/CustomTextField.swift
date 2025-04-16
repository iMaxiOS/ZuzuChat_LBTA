//
//  CustomTextField.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

struct CustomTextField: View {
  @Binding var text: String
  
  var textFieldType: Bool
  
  var body: some View {
    VStack(spacing: 10) {
      if !textFieldType {
        HStack(spacing: 10) {
          Image(systemName: "envelope.fill")
            .resizable()
            .frame(width: 18, height: 15)
          TextField("Email", text: $text)
            .textContentType(.none)
            .padding(.vertical, 15)
            
        }
      } else {
        HStack(spacing: 10) {
          Image(systemName: "lock.fill")
            .resizable()
            .frame(width: 15, height: 18)
          
//          if isSecureTextEntry {
//            SecureField("Password", text: $text)
//              .frame(height: 45)
//          } else {
            TextField("Password", text: $text)
            .textContentType(.none)
              .padding(.vertical, 15)
//          }
          
//          Button {
//            isSecureTextEntry.toggle()
//          } label: {
//            Image(systemName: isSecureTextEntry ? "eye.fill" : "eye.slash.fill")
//              .resizable()
//              .frame(width: 18, height: 15)
//          }
//          .padding(10)
//          .buttonStyle(.plain)
        }
      }
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  SignInView()
}
