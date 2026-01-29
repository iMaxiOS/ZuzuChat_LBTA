//
//  SessionManager.swift
//  Be_Friends
//
//  Created by Maxim Hranchenko on 25.07.2023.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class SessionManager {
  
  @ObservationIgnored @AppStorage("isAuthorizedUser") private var storedIsAuthorized: Bool = false

  private(set) var user: UserModel?

  var onboardingType: OnboardingType = .onboarding
  
  init() {
    Task {
      await restoreSession()
    }
  }
  
  func login() async {
    await loadUser()
    
    guard let user else { return }
    
    do {
      try await UserStorage.shared.saveUser(user)
      self.user = user
      storedIsAuthorized = true
      onboardingType = .tabbar
    } catch {
      print("Failed to save user:", error)
    }
  }
  
  func restoreSession() async {
    do {
      if let loadUser = try await UserStorage.shared.loadUser() {
        self.user = loadUser
        onboardingType = storedIsAuthorized ? .tabbar : .login
      } else {
        onboardingType = .onboarding
      }
    } catch {
      resetSession()
      print("❌ Restore session error:", error.localizedDescription)
    }
  }
  
  func authorize(user newUser: UserModel) async {
    do {
      let user = newUser
      try await UserStorage.shared.saveUser(user)
      
      self.user = user
      storedIsAuthorized = true
      onboardingType = .tabbar
    } catch {
      print("❌ Authorization error:", error.localizedDescription)
    }
  }
  
  func logoutSession() async {
    resetSession()
  }
  
  func deleteAccountSession() async {
    do {
      try await UserStorage.shared.deleteUser()
      resetSession()
    } catch {
      print("❌ Delete account error:", error.localizedDescription)
    }
  }
  
  private func resetSession() {
    storedIsAuthorized = false
    user = nil
    onboardingType = .login
  }
  
  private func loadUser() async {
    do {
      if let savedUser = try await UserStorage.shared.loadUser() {
        self.user = savedUser
      } else {
        onboardingType = .chooseInterest
      }
    } catch {
      print("Failed to load user:", error)
      onboardingType = .login
    }
  }
}
