//
//  BottomInformationView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.01.2026.
//

import SwiftUI

struct BottomInformationView: View {
  @Environment(SessionManager.self) private var session
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Image(uiImage: base64ToImage(session.user?.avatar ??  "") ?? UIImage())
          .resizable()
          .scaledToFill()
          .frame(width: 55, height: 55)
          .clipShape(.circle)
        
        VStack(alignment: .leading, spacing: 10) {
          Text((session.user?.fullName ?? "") + " " + (session.user?.nickname ?? ""))
            .font(.headline.bold().monospaced())
            .foregroundStyle(.white)
          Text("Actor & Singer")
            .foregroundStyle(.gray)
            .font(.footnote.italic())
        }
      }
      
      Text("Hi everyone in this video i will sing o song\n&song &music &love &beauty")
        .font(.footnote.bold())
      
      HStack {
        Image(systemName: "music.note")
        Text("Following Girl by \(session.user?.nickname ?? "")")
          .font(.caption.bold().monospaced())
      }
    }
    .foregroundStyle(.gray)
    .padding(.horizontal)
  }
}
