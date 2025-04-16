//
//  ProfileView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI

struct ProfileView: View {
  @EnvironmentObject private var session: SessionManager
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      contentView
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
  }
}

private extension ProfileView {
  var contentView: some View {
    VStack(alignment: .leading, spacing: 20) {
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          Text("Profile")
            .font(.title2.bold().monospaced())
          
          Spacer()
          
          Button {} label: {
            Image(systemName: "00.circle.ar")
              .imageScale(.large)
          }
        }
        
        HStack {
          Image(uiImage: base64ToImage(session.user.avatar ?? "") ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipShape(.circle)
          
          VStack(alignment: .leading, spacing: 15) {
            Text((session.user.fullName ?? "") + " " + (session.user.nickname ?? ""))
              .font(.headline.bold().monospaced())
            Text(session.user.phone ?? "")
              .font(.footnote.monospaced())
          }
          
          Spacer()
          
          Button {} label: {
            Image(systemName: "pencil.line")
              .imageScale(.large)
              .padding([.vertical, .leading])
              .foregroundStyle(Color(.pink))
              .padding([.vertical, .leading])
          }
        }
        .padding(.top, 30)
        .padding(.bottom)
        
        RoundedRectangle(cornerRadius: 1)
          .frame(height: 1)
          .foregroundStyle(.white.opacity(0.1))
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 0) {
            VStack(spacing: 0) {
              ProfileRow(icon: "calendar", title: "My Favorite Restaurants") { }
              ProfileRow(icon: "cup.and.saucer", title: "Special Offers & Promo") { }
              ProfileRow(icon: "wallet.bifold", title: "Payment Methods") { }
            }
            .padding(.top, 8)
            
            RoundedRectangle(cornerRadius: 1)
              .frame(height: 1)
              .foregroundStyle(.white.opacity(0.1))
            
            VStack(spacing: 0) {
              ProfileRow(icon: "person", title: "Profile") { }
              ProfileRow(icon: "location.app", title: "Address") { }
              ProfileRow(icon: "bell", title: "Notification") { }
              ProfileRow(icon: "lock.shield", title: "Security") { }
              ProfileRow(icon: "globe", title: "Language", subtitle: "English(US)") { }
              ProfileRow(icon: "eye", title: "Dark Mode") { }
              ProfileRow(icon: "info.triangle", title: "Help Center") { }
              ProfileRow(icon: "person.2", title: "Invite Friends") { }
              ProfileRow(icon: "rectangle.portrait.and.arrow.right", title: "Logout") {
                session.logoutSession()
              }
            }
          }
          .padding(.bottom, 50)
        }
      }
      .padding(.horizontal, 20)
    }
    .padding(.top)
  }
}

struct ProfileRow: View {
  let icon: String
  let title: String
  var subtitle: String? = nil
  var closure: () -> Void
  
  var body: some View {
    Button {
      closure()
    } label: {
      HStack(spacing: 15) {
        Image(systemName: icon)
          .foregroundColor(title == "Logout" ? .red : .gray)
          .imageScale(.large)
          .bold()
          .frame(width: 25)
        
        Text(title)
          .font(.subheadline.bold().monospaced())
          .foregroundStyle(title == "Logout" ? .red : .white)
        
        Spacer()
        
        if let subtitle = subtitle {
          Text(subtitle)
            .foregroundColor(.gray)
            .font(.subheadline.bold())
        }
        
        if title == "Dark Mode" {
          Toggle(isOn: .constant(true)) { Text("") }
            .padding(.trailing, 2)
            .toggleStyle(SwitchToggleStyle(tint: .green))
        } else {
          Image(systemName: title == "Logout" ? "" : "chevron.right")
            .foregroundColor(.gray)
            .imageScale(.small).bold()
        }
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 5)
    }
  }
}


#Preview {
  ProfileView()
    .environmentObject(SessionManager())
}
