//
//  PinView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 28.03.2025.
//

import SwiftUI

enum PushType {
  case otp
  case forgetPassword
}

struct OTPPinOrForgetPasswordView: View {
  @Bindable var session: SessionManager
  @Environment(AppRouterManager.self) private var router
  
  @State private var focusedIndex: Int? = nil
  @State private var otp: [String] = Array(repeating: "", count: 4)
  @State private var showKeypad = false
  @State private var isCongratulation = false
  @State private var isShowHome = false
  
  @State var pushType: PushType?
  
  let keypadRows: [[String]] = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
    ["", "0", "⌫"]
  ]
  
  var body: some View {
    ZStack {
      Color.bg
      
      content
    }
    .foregroundStyle(.white)
    .overlay(alignment: .bottom) {
      VStack(spacing: 0) {
        ForEach(keypadRows, id: \.self) { row in
          HStack(spacing: 0) {
            ForEach(row, id: \.self) { item in
              Button {
                handleKeyPress(item)
              } label: {
                Text(item)
                  .padding(16)
                  .frame(maxWidth: .infinity)
                  .foregroundColor(.white)
                  .font(.title2.bold())
              }
              .disabled(item.isEmpty)
            }
          }
        }
      }
      .padding()
      .background(.grayBlue)
      .cornerRadius(20)
      .offset(y: showKeypad ? 0 : 400)
    }
    .overlay(content: {
      if isCongratulation {
        ZStack {
          Color.black.opacity(0.5)
          CongratulationView()
            .onAppear {
              DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.bouncy) {
                  isCongratulation.toggle()
                  router.push(AppRouterType.tabbar)
                }
              }
            }
        }
      }
    })
    .navigationTitle(Text(pushType == .otp ? "Create New PIN" : "Forget Password"))
    .onTapGesture {
      withAnimation {
        showKeypad = false
        focusedIndex = nil
      }
    }
    .ignoresSafeArea()
    .onAppear {
      withAnimation {
        focusedIndex = 0
        showKeypad = true
      }
    }
  }
  
  private func handleKeyPress(_ key: String) {
    guard let index = focusedIndex else {
      return
    }
    
    if key == "⌫" {
      if !otp[index].isEmpty {
        otp[index] = ""
      } else if index > 0 {
        otp[index - 1] = ""
        focusedIndex = index - 1
      }
    } else if key != "" {
      if otp[index].isEmpty {
        otp[index] = key
        if index < 3 {
          focusedIndex = index + 1
        }
      }
    }
  }
}

private extension OTPPinOrForgetPasswordView {
  var content: some View {
    VStack(alignment: .leading, spacing: 20) {
      VStack(spacing: 0) {
        Text(pushType == .otp ? "Add a PIN number to make your account more secure." : "Code has been sent to +1 111.....99")
          .font(.footnote.bold().monospaced())
          .multilineTextAlignment(.center)
        
        HStack(spacing: 10) {
          ForEach(0..<4, id: \.self) { index in
            TextField("", text: $otp[index])
              .frame(height: 50)
              .background(focusedIndex == index ? Color(.pink.opacity(0.1)) : Color.grayBlue)
              .cornerRadius(10)
              .multilineTextAlignment(.center)
              .foregroundColor(.white)
              .font(.title2.bold())
              .disabled(true)
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(focusedIndex == index ? Color(.pink) : Color.clear, lineWidth: 1)
              )
              .onTapGesture {
                withAnimation {
                  focusedIndex = index
                  showKeypad = true
                }
              }
          }
        }
        .padding(.horizontal, 10)
        .padding(.top, showKeypad ? 50 : 70)
        
        Spacer()
        
        Button {
          session.user.OTPPin = otp.joined(separator: "")
          
          withAnimation(.bouncy(duration: 0.7)) {
            isCongratulation.toggle()
            showKeypad = false
            focusedIndex = nil
          }
        } label: {
          Text("Continue")
            .font(.headline.bold().monospaced())
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(Color(.pink)))
            .clipShape(.rect(cornerRadius: 50))
        }
        .padding(.bottom, showKeypad ? 320 : 50)
        .buttonStyle(.plain)
        .disabled(otp.joined().count < 4)
        
      }
      .frame(maxWidth: .infinity, alignment: .center)
      .padding(.top, 150)
      .padding(.horizontal, 10)
    }
  }
}

#Preview {
  NavigationStack {
    OTPPinOrForgetPasswordView(session: .init())
      .environment(SessionManager())
      .navigationBarTitleDisplayMode(.inline)
  }
}
