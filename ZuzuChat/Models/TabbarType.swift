//
//  TabbarType.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import Foundation

enum TabbarType: String, CaseIterable {
  case home, explore, phone, chat, profile
  
  var name: String {
    switch self {
    case .home: return "Home"
    case .explore: return "Explore"
    case .phone: return ""
    case .chat: return "Chat"
    case .profile: return "Profile"
    }
  }
  
  var image: String {
    switch self {
    case .home: return "house.fill"
    case .explore: return "list.bullet.clipboard.fill"
    case .phone: return "phone.fill"
    case .chat: return "message.fill"
    case .profile: return "person.fill"
    }
  }
  
  var unSelectedImage: String {
    switch self {
    case .home: return "house"
    case .explore: return "list.bullet.clipboard"
    case .phone: return "phone"
    case .chat: return "message"
    case .profile: return "person"
    }
  }
}
