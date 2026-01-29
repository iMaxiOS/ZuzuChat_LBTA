//
//  AppRouter.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.01.2026.
//

import Observation
import SwiftUI

@Observable
final class AppRouterManager {
  var path = NavigationPath()
  var selectedTab: TabbarType = .home
  
  func push<T: Hashable>(_ route: T) {
    path.append(route)
  }
  
  func pop() {
    guard !path.isEmpty else { return }
    path.removeLast()
  }
  
  func popToRoot() {
    path = NavigationPath()
  }
}
