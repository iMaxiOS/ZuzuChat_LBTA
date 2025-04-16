//
//  AboutYourSelfView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI

enum AboutYourSelfState: String {
  case male, female, none
}

struct AboutYourSelfView: View {
  @EnvironmentObject var session: SessionManager
  
  @State private var aboutMe: AboutYourSelfState = .none
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          BackButton()
          
          Text("Tell Us About Yourself")
            .font(.headline.bold().monospaced())
        }
        
        Text("Choose your identity & help us to find accurate content for you.")
          .font(.footnote.bold().monospaced())
          .padding(.horizontal, 20)
        
        Spacer()
        
        VStack(spacing: 25) {
          Button {
            aboutMe = .male
          } label: {
            Circle()
              .fill(
                LinearGradient(colors: aboutMe != .male ? [.grayBlue] : [.white.opacity(0.9), Color(.pink)], startPoint: .leading, endPoint: .trailing)
              )
              .overlay {
                VStack(spacing: 10) {
                  Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                  Text("Male")
                    .font(.title.bold().monospaced())
                }
              }
              .frame(width: 200, height: 200)
          }
          
          Button {
            aboutMe = .female
          } label: {
            Circle()
              .fill(
                LinearGradient(colors: aboutMe == .female ? [.white.opacity(0.9), Color(.pink)] : [.grayBlue], startPoint: .leading, endPoint: .trailing)
              )
              .overlay {
                VStack(spacing: 10) {
                  Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                  Text("Famale")
                    .font(.title.bold().monospaced())
                }
              }
              .frame(width: 200, height: 200)
          }
          
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 20)
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            session.navigate(to: .birthday)
          } label: {
            Text("Skip")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(.grayBlue)
              .clipShape(.rect(cornerRadius: 50))
          }
          
          Button {
            session.user.about = aboutMe.rawValue
            session.navigate(to: .birthday)
          } label: {
            Text("Continue")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(Color(.pink)))
              .clipShape(.rect(cornerRadius: 50))
          }
        }
        .padding(.horizontal, 20)
      }
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
  }
}

#Preview {
  AboutYourSelfView()
    .environmentObject(SessionManager())
}
