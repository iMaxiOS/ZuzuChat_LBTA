//
//  User.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 07.04.2025.
//

import Foundation

//final class UserManager {
//  static let shared = UserManager()
//  
//  private init() {}
//  
//  let fileName = "user_data.json"
//  
//  func userFilePath() async -> String {
//      let fileManager = FileManager.default
//      let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
//      
//      guard let documentsDirectory = urls.first else {
//          fatalError("Failed to load folder for Documents")
//      }
//
//    return documentsDirectory.appendingPathComponent(fileName).path
//  }
//  
//  func saveUser(_ user: UserModel) async throws {
//      let encoder = JSONEncoder()
//    
//      if let data = try? encoder.encode(user) {
//          await FileManager.default.createFile(atPath: userFilePath(), contents: data)
//      }
//  }
//
//  func deleteUser() async throws {
//      try await FileManager.default.removeItem(atPath: userFilePath())
//  }
//
//  func loadUser() async throws -> UserModel? {
//      if let data = await FileManager.default.contents(atPath: userFilePath()) {
//          return try JSONDecoder().decode(UserModel.self, from: data)
//      }
//      return nil
//  }
//}

final class UserManager {

    static let shared = UserManager()
    private init() {}

    private let fileName = "user_data.json"

    // MARK: - File URL

    private var fileURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

    // MARK: - Save

    func saveUser(_ user: UserModel) async throws {
        let data = try JSONEncoder().encode(user)

        try await Task.detached(priority: .utility) {
            try data.write(to: self.fileURL, options: .atomic)
        }.value
    }

    // MARK: - Load

    func loadUser() async throws -> UserModel? {
        try await Task.detached(priority: .utility) {
            guard FileManager.default.fileExists(atPath: self.fileURL.path) else {
                return nil
            }

            let data = try Data(contentsOf: self.fileURL)
            return try JSONDecoder().decode(UserModel.self, from: data)
        }.value
    }

    // MARK: - Delete

    func deleteUser() async throws {
        try await Task.detached(priority: .utility) {
            guard FileManager.default.fileExists(atPath: self.fileURL.path) else {
                return
            }

            try FileManager.default.removeItem(at: self.fileURL)
        }.value
    }
}
