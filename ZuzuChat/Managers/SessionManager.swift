//
//  SessionManager.swift
//  Be_Friends
//
//  Created by Maxim Hranchenko on 25.07.2023.
//

import Foundation
import SwiftUI

@MainActor
final class SessionManager: ObservableObject {
  @Published var isAuthorized: Bool = false
  @Published var navigatePath: [NavigationType] = []
  @Published var user = UserModel()
  
  public init() {
    getCurrentUserSession()
  }
  
  func getCurrentUserSession() {
    if FileManager.default.fileExists(atPath: UserManager.shared.userFilePath()) {
      let currentUser = UserManager.shared.loadUser()
      _user = .init(wrappedValue: currentUser ?? .init())
      isAuthorized = true
    } else {
      isAuthorized = false
    }
  }
  
  func navigate(to: NavigationType) {
    navigatePath.append(to)
  }
  
  func logoutSession() {
    UserManager.shared.deleteUser()
    isAuthorized = false
    navigatePath.removeAll()
  }
}
