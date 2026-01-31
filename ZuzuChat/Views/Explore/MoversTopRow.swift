//
//  MoversTopRow.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI

struct MoversTopRow: View {
  var item: Movers
  
  var body: some View {
    VStack(spacing: 10) {
      Image(item.icon)
        .resizable()
        .frame(width: 100, height: 100)
        .overlay {
          Circle()
            .stroke(Color(.pink), lineWidth: 4)
        }
      
      Text(item.title)
        .font(.headline.bold().monospaced())
      
      Text(item.percent)
        .font(.subheadline.bold())
        .foregroundStyle(Color(.pink))
    }
    .padding(4)
  }
}
