//
//  SessionManager.swift
//  Be_Friends
//
//  Created by Maxim Hranchenko on 25.07.2023.
//

import Foundation
import SwiftUI

//@MainActor @Observable
//final class SessionManager {
//  var user = UserModel()
//  var onboardingType: OnboardingType = .onboarding
//
//  public init() {
//    Task {
//      do {
//        _ = try await getCurrentUserSession()
//      } catch {
//        print(error.localizedDescription)
//      }
//    }
//  }
//
//  func getCurrentUserSession() async throws -> UserModel? {
//    do {
//      let path = await UserManager.shared.userFilePath()
//
//      if FileManager.default.fileExists(atPath: path) {
//        if let currentUser = try await UserManager.shared.loadUser() {
//          user = currentUser
//          return user
//        }
//      }
//    } catch {
//      print(error.localizedDescription)
//    }
//
//    return nil
//  }
//
//  func logoutSession() async {
//    do {
//      user.isAuthorized = false
//      onboardingType = .login
//
//      try await UserManager.shared.saveUser(user)
//    } catch {
//      print(error.localizedDescription)
//    }
//  }
//
//  func deleteAccountSession() async {
//    do {
//      user.isAuthorized = false
//      onboardingType = .login
//
//      try await UserManager.shared.deleteUser()
//    } catch {
//      print(error.localizedDescription)
//    }
//  }
//}

@MainActor
@Observable
final class SessionManager {
  
  private(set) var user: UserModel?
  var onboardingType: OnboardingType = .onboarding
  
  init() {
    Task {
      await restoreSession()
    }
  }
  
  func login() async {
    await loadUser()
    
    guard var user else { return }
    
    user.isAuthorized = true
    
    do {
      try await UserManager.shared.saveUser(user)
      self.user = user
      onboardingType = .tabbar
    } catch {
      print("Failed to save user:", error)
    }
  }
  
  func restoreSession() async {
    do {
      if let loadUser = try await UserManager.shared.loadUser() {
        self.user = loadUser
        
        if loadUser.isAuthorized {
          onboardingType = .tabbar
        } else {
          onboardingType = .login
        }
      } else {
        onboardingType = .login
      }
    } catch {
      resetSession()
      print("❌ Restore session error:", error.localizedDescription)
    }
  }
  
  func authorize(user newUser: UserModel) async {
    do {
      var user = newUser
      user.isAuthorized = true
      
      try await UserManager.shared.saveUser(user)
      
      self.user = user
      onboardingType = .tabbar
    } catch {
      print("❌ Authorization error:", error.localizedDescription)
    }
  }
  
  func logoutSession() async {
    do {
      if var user {
        user.isAuthorized = false
        try await UserManager.shared.saveUser(user)
      }
      
      resetSession()
    } catch {
      print("❌ Logout error:", error.localizedDescription)
    }
  }
  
  func deleteAccountSession() async {
    do {
      try await UserManager.shared.deleteUser()
      resetSession()
    } catch {
      print("❌ Delete account error:", error.localizedDescription)
    }
  }
  
  private func updateOnboardingState() {
    guard let user else {
      onboardingType = .onboarding
      return
    }
    
    onboardingType = user.isAuthorized ? .tabbar : .login
  }
  
  private func resetSession() {
    user = nil
    onboardingType = .login
  }
  
  private func loadUser() async {
    do {
      if let savedUser = try await UserManager.shared.loadUser() {
        self.user = savedUser
      } else {
        onboardingType = .login
      }
    } catch {
      print("Failed to load user:", error)
      onboardingType = .login
    }
  }
}
