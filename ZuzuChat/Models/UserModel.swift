//
//  UserManager.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 01.04.2025.
//

import Foundation

struct UserModel: Codable, Identifiable {
  var id: UUID?
  var email: String?
  var isAuthorized: Bool = false
  var fullName: String?
  var avatar: String?
  var interests: Set<String> = []
  var about: String?
  var birthday: Date?
  var nickname: String?
  var phone: String?
  var address: String?
}
