//
//  CategoryChip.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI

struct CategoryChip: View {
  @State var category: CategoryItem
  
  var body: some View {
    Text("\(category.icon) \(category.title)")
      .font(.system(size: 16, weight: .medium))
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(Color.gray.opacity(0.2))
      .cornerRadius(20)
      .background(
        category.isSelected ? Color(.pink).opacity(0.2) : Color.black.opacity(0.2)
      )
      .foregroundColor(category.isSelected ? Color(.pink) : .white)
      .clipShape(Capsule())
      .overlay(
        Capsule()
          .stroke(category.isSelected ? Color(.pink) : Color.gray, lineWidth: 1)
      )
      .onTapGesture {
        category.isSelected.toggle()
      }
  }
}
