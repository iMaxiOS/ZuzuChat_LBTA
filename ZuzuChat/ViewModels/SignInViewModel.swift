//
//  LoginViewModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import Observation

@Observable @MainActor
final class SignInViewModel {
  var email: String = ""
  var password: String = ""
  var isLoading: Bool = false
  var isShowWarning: Bool = false
  
  func checkingCredentials() -> Bool {
    if email.isEmpty && password.isEmpty {
      return false
    }
    
    if email == "Admin" && password == "123456" {
      return true
    }
    
    return false
  }
}
