//
//  ExploreModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 04.04.2025.
//

import Foundation

struct CategorySection: Identifiable {
  let id = UUID()
  let title: String
  var categories: [CategoryItem]
}

struct CategoryItem: Identifiable {
  let id = UUID()
  let title: String
  let icon: String
  var isSelected: Bool = false
}

struct Movers: Identifiable {
  let id = UUID()
  let icon: String
  let title: String
  let percent: String
}


