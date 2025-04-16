//
//  User.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 07.04.2025.
//

import Foundation

final class UserManager {
  static let shared = UserManager()
  
  private init() {}
  
  let fileName = "user_data.json"
  
  func userFilePath() -> String {
      let fileManager = FileManager.default
      let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
      
      guard let documentsDirectory = urls.first else {
          fatalError("Failed to load folder for Documents")
      }

    return documentsDirectory.appendingPathComponent(UserManager.shared.fileName).path
  }
  
  func saveUser(_ user: UserModel) {
      let encoder = JSONEncoder()
      if let data = try? encoder.encode(user) {
          FileManager.default.createFile(atPath: userFilePath(), contents: data)
      }
  }

  func deleteUser() {
      try? FileManager.default.removeItem(atPath: userFilePath())
  }

  func loadUser() -> UserModel? {
      if let data = FileManager.default.contents(atPath: userFilePath()) {
          return try? JSONDecoder().decode(UserModel.self, from: data)
      }
      return nil
  }
}
