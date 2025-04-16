//
//  Ext+UserDefault.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 01.04.2025.
//

import Foundation

extension UserDefaults {
  func saveUser(_ user: UserModel) {
    if let encoded = try? JSONEncoder().encode(user) {
      print("User save successful")
      self.set(encoded, forKey: "User_Key")
    }
    
    print("User not save!")
  }
  
  func loadUser() -> UserModel? {
    if let savedData = self.data(forKey: "User_Key"),
       let decodedUser = try? JSONDecoder().decode(UserModel.self, from: savedData) {
      print("User loaded successful")
      return decodedUser
    }
    print("User failed to load")
    return nil
  }
}
