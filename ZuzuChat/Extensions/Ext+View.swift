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
            OnboardingView(session: session)
          case .login:
            LoginView(session: session)
          case .tabbar:
            TabbarView(session: session)
          case .signUp:
            SignUpView(session: session)
          case .signIn:
            SignInView(session: session)
          case .chooseInterest:
            ChooseInterestView(session: session)
          case .aboutYourSelf:
            AboutYourSelfView(session: session)
          case .birthday:
            BirthdayView(session: session)
          case .fillProfile:
            FillProfileView(session: session)
          case .pinOrForget(let type):
            OTPPinOrForgetPasswordView(session: session, pushType: type)
          case .forgotPassword:
            ForgetPasswordView(session: session)
          case .report:
            ReportView()
          case .message(let article):
            MessageDetailView(article: article)
          case .explore(let new):
            ExploreDetailView(new: new)
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

//@MainActor
//extension View {
//  func withAppRouter(session: SessionManager) -> some View {
//    navigationDestination(for: AppRouteManager.self) { destination in
//      switch destination {
//      case .onboarding:
//        OnboardingView(session: session)
//      case .login:
//        LoginView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .main:
//        TabbarView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .signUp:
//        SignUpView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .signIn:
//        SignInView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .chooseInterest:
//        ChooseInterestView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .aboutYourSelf:
//        AboutYourSelfView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .birthday:
//        BirthdayView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .fillProfile:
//        FillProfileView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .pinOrForget(let type):
//        OTPPinOrForgetPasswordView(session: session, pushType: type)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .forgotPassword:
//        ForgetPasswordView(session: session)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .report:
//        ReportView()
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .message(let article):
//        MessageView(article: article)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      case .explore(let new):
//        ExploreDetailView(new: new)
////          .toolbarVisibility(.hidden, for: .navigationBar)
////          .environment(session)
//      }
//    }
//  }
//}
