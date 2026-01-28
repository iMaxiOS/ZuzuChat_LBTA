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
  @State private var onboardingVM = OnboardingViewModel()
  
  var body: some Scene {
    WindowGroup {
      Group {
          switch session.onboardingType {
          case .login:
            LoginView()
              .environment(session)
              .environment(onboardingVM)
          case .signIn:
            SignInView()
              .environment(session)
              .environment(onboardingVM)
          case .otpCode:
            OTPPinOrForgetPasswordView()
              .environment(session)
              .environment(onboardingVM)
          case .birthday:
            BirthdayView()
              .environment(session)
              .environment(onboardingVM)
          case .chooseInterest:
            ChooseInterestView()
              .environment(session)
              .environment(onboardingVM)
          case .fillProfile:
            FillProfileView()
              .environment(session)
              .environment(onboardingVM)
          case .forgetPassword:
            ForgetPasswordView()
              .environment(session)
              .environment(onboardingVM)
          case .aboutYourSelf:
            AboutYourSelfView()
              .environment(session)
              .environment(onboardingVM)
          case .pinOrForget(type: .otp):
            OTPPinOrForgetPasswordView()
              .environment(session)
              .environment(onboardingVM)
          case .tabbar:
            TabbarView()
              .environment(session)
          case .onboarding:
            OnboardingView()
              .environment(session)
          case .pinOrForget(type: .forgetPassword):
            ForgetPasswordView()
              .environment(session)
              .environment(onboardingVM)
          }
      }
    }
  }
}
