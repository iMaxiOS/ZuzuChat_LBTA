//
//  MessageBubble.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI

struct MessageBubble: View {
  let message: Message
  
  var body: some View {
    HStack {
      if message.isSent { Spacer() }
      
      VStack(alignment: message.isSent ? .trailing : .leading, spacing: 4) {
        Text(message.text)
          .padding()
          .glassEffect(.clear, in: .rect(cornerRadius: 25))
        
        Text(message.time)
          .font(.caption)
          .padding(message.isSent ? .trailing : .leading, 10)
          .frame(maxWidth: .infinity, alignment: message.isSent ? .trailing : .leading)
      }
      .frame(maxWidth: 300, alignment: message.isSent ? .trailing : .leading)
    }
    .padding(.horizontal)
  }
}
