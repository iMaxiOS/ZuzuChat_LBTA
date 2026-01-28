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
          
          SecureField("Password", text: $text)
            .textContentType(.none)
            .padding(.vertical, 15)
        }
      }
    }
    .padding(.horizontal, 10)
  }
}

#Preview {
  SignInView()
}
