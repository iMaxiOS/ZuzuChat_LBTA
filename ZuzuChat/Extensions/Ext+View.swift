//
//  Ext+View.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

enum NavigationType: Hashable {
  case onboarding
  case login
  case main
  case signUp
  case signIn
  case chooseInterest
  case aboutYourSelf
  case birthday
  case fillProfile
  case pinOrForget(type: PushType)
  case forgotPassword
  case report
  case message(article: NewsResponse)
}

@MainActor
extension View {
  func withAppRouter(session: SessionManager) -> some View {
    navigationDestination(for: NavigationType.self) { destination in
      switch destination {
      case .onboarding:
        OnboardingView()
      case .login:
        LoginView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .main:
        MainView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .signUp:
        SignUpView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .signIn:
        SignInView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .chooseInterest:
        ChooseInterestView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .aboutYourSelf:
        AboutYourSelfView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .birthday:
        BirthdayView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .fillProfile:
        FillProfileView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .pinOrForget(let type):
        OTPPinOrForgetPasswordView(pushType: type)
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .forgotPassword:
        ForgetPasswordView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .report:
        ReportView()
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      case .message(let article):
        MessageView(article: article)
          .toolbarVisibility(.hidden, for: .navigationBar)
          .environmentObject(session)
      }
    }
  }
}
