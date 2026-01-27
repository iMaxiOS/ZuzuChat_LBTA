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
  case explore(new: NewsResponse)
}

@MainActor
extension View {
  func withAppRouter(session: SessionManager) -> some View {
    navigationDestination(for: NavigationType.self) { destination in
      switch destination {
      case .onboarding:
        OnboardingView(session: session)
      case .login:
        LoginView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .main:
        TabbarView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .signUp:
        SignUpView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .signIn:
        SignInView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .chooseInterest:
        ChooseInterestView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .aboutYourSelf:
        AboutYourSelfView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .birthday:
        BirthdayView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .fillProfile:
        FillProfileView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .pinOrForget(let type):
        OTPPinOrForgetPasswordView(session: session, pushType: type)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .forgotPassword:
        ForgetPasswordView(session: session)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .report:
        ReportView()
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .message(let article):
        MessageView(article: article)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      case .explore(let new):
        ExploreDetailView(new: new)
//          .toolbarVisibility(.hidden, for: .navigationBar)
//          .environment(session)
      }
    }
  }
}
