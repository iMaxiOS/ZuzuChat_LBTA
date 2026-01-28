//
//  SessionManager.swift
//  Be_Friends
//
//  Created by Maxim Hranchenko on 25.07.2023.
//

import Foundation
import SwiftUI

@MainActor @Observable
final class SessionManager {
  var user = UserModel()
  var onboardingType: OnboardingType = .onboarding
  
  public init() {
    Task {
      do {
        _ = try await getCurrentUserSession()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func getCurrentUserSession() async throws -> UserModel? {
    do {
      let path = await UserManager.shared.userFilePath()
      
      if FileManager.default.fileExists(atPath: path) {
        if let currentUser = try await UserManager.shared.loadUser() {
          user = currentUser
          return user
        }
      }
    } catch {
      print(error.localizedDescription)
    }
    
    return nil
  }
  
  func logoutSession() async {
    do {
      user.isAuthorized = false
      onboardingType = .login
      
      try await UserManager.shared.saveUser(user)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func deleteAccountSession() async {
    do {
      user.isAuthorized = false
      onboardingType = .login
      
      try await UserManager.shared.deleteUser()
    } catch {
      print(error.localizedDescription)
    }
  }
}

//@MainActor
//@Observable
//final class SessionManager {
//
//    // MARK: - State
//
//    private(set) var user: UserModel?
//    private(set) var onboardingType: OnboardingType = .onboarding
//
//    // MARK: - Init
//
//    init() {
//        Task {
//            await restoreSession()
//        }
//    }
//
//    // MARK: - Session Restore
//
//    func restoreSession() async {
//        do {
//            user = try await UserManager.shared.loadUser()
//            updateOnboardingState()
//        } catch {
//            resetSession()
//            print("❌ Restore session error:", error.localizedDescription)
//        }
//    }
//
//    // MARK: - Login
//
//    func authorize(user newUser: UserModel) async {
//        do {
//            var user = newUser
//            user.isAuthorized = true
//
//            try await UserManager.shared.saveUser(user)
//
//            self.user = user
//            onboardingType = .authorized
//        } catch {
//            print("❌ Authorization error:", error.localizedDescription)
//        }
//    }
//
//    // MARK: - Logout
//
//    func logoutSession() async {
//        do {
//            if var user {
//                user.isAuthorized = false
//                try await UserManager.shared.saveUser(user)
//            }
//
//            resetSession()
//        } catch {
//            print("❌ Logout error:", error.localizedDescription)
//        }
//    }
//
//    // MARK: - Delete Account
//
//    func deleteAccountSession() async {
//        do {
//            try await UserManager.shared.deleteUser()
//            resetSession()
//        } catch {
//            print("❌ Delete account error:", error.localizedDescription)
//        }
//    }
//
//    // MARK: - Helpers
//
//    private func updateOnboardingState() {
//        guard let user else {
//            onboardingType = .onboarding
//            return
//        }
//
//        onboardingType = user.isAuthorized ? .authorized : .login
//    }
//
//    private func resetSession() {
//        user = nil
//        onboardingType = .login
//    }
//}
