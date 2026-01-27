//
//  CongratulationView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 31.03.2025.
//

import SwiftUI

struct CongratulationView: View {
  var body: some View {
    VStack {
      VStack(spacing: 20) {
        Image(systemName: "person.fill")
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.white)
          .frame(width: 60, height: 60)
          .padding(40)
          .frame(width: 150, height: 150)
          .background(Color(.pink))
          .clipShape(.circle)
        
        Text("Congratulations!")
          .foregroundStyle(Color(.pink))
          .font(.title2.bold().monospaced())
        
        Text("Your account is ready to use. You will\nbe redirect to the Home page in a\nfew second.")
          .foregroundStyle(.gray)
          .font(.headline.bold())
          .multilineTextAlignment(.center)
        
        CircularGrowingLoader()
          .padding(.vertical, 30)
      }
      .padding(.top, 50)
      .padding(.bottom, 20)
      .padding(.horizontal, 30)
    }
    .background(Color.bg)
    .clipShape(.rect(cornerRadius: 50))
    .padding(.horizontal, 10)
  }
}

#Preview {
  CongratulationView()
}
