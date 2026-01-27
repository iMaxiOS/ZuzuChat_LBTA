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
  var isAuthorized: Bool = false
//  var navigatePath: [NavigationType] = []
  var user = UserModel()
  
  public init() {
    getCurrentUserSession()
  }
  
  func getCurrentUserSession() {
    if FileManager.default.fileExists(atPath: UserManager.shared.userFilePath()) {
      let currentUser = UserManager.shared.loadUser()
      user = currentUser ?? .init()
      isAuthorized = true
      print(isAuthorized)
    } else {
      isAuthorized = false
      print(isAuthorized)
    }
  }
  
  func logoutSession() {
    isAuthorized = false
  }
  
  func deleteAccountSession() {
    UserManager.shared.deleteUser()
    isAuthorized = false
  }
}
