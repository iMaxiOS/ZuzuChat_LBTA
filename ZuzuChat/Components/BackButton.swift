//
//  File.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 02.04.2025.
//

import SwiftUI


struct BackButton: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Button {
      dismiss.callAsFunction()
    } label: {
      Image(systemName: "arrow.left")
        .bold()
        .padding([.vertical, .trailing])
    }
    .padding(.leading)
    .buttonStyle(.plain)
  }
}
