//
//  OnboardingType.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 29.01.2026.
//

import Foundation

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
