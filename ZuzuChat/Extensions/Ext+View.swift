//
//  Ext+View.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

enum AppRouterType: Hashable {
  case onboarding
  case login
  case tabbar
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

struct AppRouterModifier: ViewModifier {
  @State private var router = AppRouterManager()
  @State private var session = SessionManager()
  
  func body(content: Content) -> some View {
    NavigationStack(path: $router.path) {
      content
        .environment(router)
        .navigationDestination(for: AppRouterType.self) { destination in
          switch destination {
          case .onboarding:
            OnboardingView()
              .environment(session)
          case .login:
            LoginView()
              .environment(session)
          case .tabbar:
            TabbarView()
              .environment(session)
          case .signUp:
            SignUpView()
              .environment(session)
          case .signIn:
            SignInView()
              .environment(session)
          case .chooseInterest:
            ChooseInterestView()
              .environment(session)
          case .aboutYourSelf:
            AboutYourSelfView()
              .environment(session)
          case .birthday:
            BirthdayView()
              .environment(session)
          case .fillProfile:
            FillProfileView()
              .environment(session)
          case .pinOrForget(let type):
            OTPPinOrForgetPasswordView(pushType: type)
              .environment(session)
          case .forgotPassword:
            ForgetPasswordView()
              .environment(session)
          case .report:
            ReportView()
              .environment(session)
          case .message(let article):
            MessageDetailView(article: article)
              .environment(session)
          case .explore(let new):
            ExploreDetailView(new: new)
              .environment(session)
          }
        }
    }
  }
}

extension View {
    func withAppRouter() -> some View {
        modifier(AppRouterModifier())
    }
}
