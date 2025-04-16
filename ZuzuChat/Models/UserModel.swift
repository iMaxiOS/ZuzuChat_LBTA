//
//  UserManager.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 01.04.2025.
//

import Foundation

final class UserModel: ObservableObject, Codable, Identifiable {
  var id: UUID
  var email: String
  var password: String
  var avatar: String?
  var interests: Set<String>
  var about: String?
  var birthday: Date?
  var fullName: String?
  var nickname: String?
  var phone: String?
  var address: String?
  var OTPPin: String
  
  
  init(
    id: UUID,
    email: String,
    password: String,
    avatar: String?,
    interests: Set<String>,
    about: String?,
    birthday: Date?,
    fullName: String?,
    nickname: String?,
    phone: String?,
    address: String?,
    OTPPin: String
  ) {
    self.id = UUID()
    self.email = email
    self.password = password
    self.avatar = avatar
    self.interests = interests
    self.about = about
    self.birthday = birthday
    self.fullName = fullName
    self.nickname = nickname
    self.phone = phone
    self.address = address
    self.OTPPin = OTPPin
  }
  
  init () {
    self.id = UUID()
    self.email = ""
    self.password = ""
    self.avatar = nil
    self.interests = []
    self.about = nil
    self.birthday = nil
    self.fullName = nil
    self.nickname = nil
    self.phone = nil
    self.address = nil
    self.OTPPin = ""
  }
}
