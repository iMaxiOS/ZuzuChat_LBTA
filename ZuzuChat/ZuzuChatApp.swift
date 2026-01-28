//
//  ZuzuChatApp.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

enum OnboardingType: Hashable {
  case onboarding
  case login
  case forgetPassword
  case otpCode
  case tabbar
  case signIn
  case pinOrForget(type: PushType)
  case chooseInterest
  case aboutYourSelf
  case fillProfile
  case birthday
}

@main
struct ZuzuChatApp: App {
  @State private var session = SessionManager()
  
  var body: some Scene {
    WindowGroup {
      Group {
        if session.user.isAuthorized {
          TabbarView()
            .environment(session)
        } else {
          switch session.onboardingType {
          case .login:
            LoginView()
              .environment(session)
          case .signIn:
            SignInView()
              .environment(session)
          case .otpCode:
            OTPPinOrForgetPasswordView()
              .environment(session)
          case .birthday:
            BirthdayView()
              .environment(session)
          case .chooseInterest:
            ChooseInterestView()
              .environment(session)
          case .fillProfile:
            FillProfileView()
              .environment(session)
          case .forgetPassword:
            ForgetPasswordView()
              .environment(session)
          case .aboutYourSelf:
            AboutYourSelfView()
              .environment(session)
          case .pinOrForget(type: .otp):
            OTPPinOrForgetPasswordView()
              .environment(session)
          case .tabbar:
            TabbarView()
              .environment(session)
          case .onboarding:
            OnboardingView()
              .environment(session)
          case .pinOrForget(type: .forgetPassword):
            ForgetPasswordView()
              .environment(session)
          }
        }
      }
    }
  }
}
