//
//  ZuzuChatApp.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

@main
struct ZuzuChatApp: App {
  @State private var session = SessionManager()
  @State private var router = AppRouterManager()
  @State private var onboardingVM = OnboardingViewModel()
  
  @AppStorage("systemTheme") private var systemScheme: Bool = false
  
  private var selectedScheme: ColorScheme? {
    systemScheme ? .dark : .light
  }
  
  var body: some Scene {
    WindowGroup {
      ZStack {
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
            .environment(router)
        case .onboarding:
          OnboardingView()
            .environment(session)
        case .pinOrForget(type: .forgetPassword):
          ForgetPasswordView()
            .environment(session)
            .environment(onboardingVM)
        }
      }
      .preferredColorScheme(selectedScheme)
    }
  }
}
