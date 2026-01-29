//
//  ProfileView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI

struct ProfileView: View {
  @Environment(SessionManager.self) private var session
  @Environment(AppRouterManager.self) private var router
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      contentView
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {} label: {
          Image(systemName: "pencil.line")
            .imageScale(.large)
        }
      }
    }
  }
}

private extension ProfileView {
  var contentView: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          if let user = session.user {
          Image(uiImage: base64ToImage(user.avatar ?? "") ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipShape(.circle)
          
          VStack(alignment: .leading, spacing: 15) {
              Text((user.fullName ?? "") + " " + (user.nickname ?? ""))
                .font(.headline.bold().monospaced())
              Text(user.phone ?? "")
                .font(.footnote.monospaced())
            }
          }
          
          Spacer()
        }
        .padding(.top, 30)
        .padding(.bottom)
        
        RoundedRectangle(cornerRadius: 1)
          .frame(height: 1)
          .foregroundStyle(.white.opacity(0.1))
        
        VStack(spacing: 0) {
          VStack(spacing: 0) {
            ProfileRow(icon: "calendar", title: "My Favorite Restaurants")
            ProfileRow(icon: "cup.and.saucer", title: "Special Offers & Promo")
            ProfileRow(icon: "wallet.bifold", title: "Payment Methods")
          }
          .padding(.top, 8)
          
          RoundedRectangle(cornerRadius: 1)
            .frame(height: 1)
            .foregroundStyle(.white.opacity(0.1))
          
          VStack(spacing: 0) {
            ProfileRow(icon: "person", title: "Profile")
            ProfileRow(icon: "location.app", title: "Address")
            ProfileRow(icon: "bell", title: "Notification")
            ProfileRow(icon: "lock.shield", title: "Security")
            ProfileRow(icon: "globe", title: "Language", subtitle: "English(US)")
            ProfileRow(icon: "eye", title: "Dark Mode")
            ProfileRow(icon: "info.triangle", title: "Help Center")
            ProfileRow(icon: "person.2", title: "Invite Friends")
            ProfileRow(icon: "rectangle.portrait.and.arrow.right", title: "Logout")
              .onTapGesture {
                Task {
                  await session.logoutSession()
                }
              }
            ProfileRow(icon: "trash", title: "Delete account")
              .onTapGesture {
              Task {
                await session.deleteAccountSession()
              }
            }
          }
        }
        .padding(.bottom, 50)
      }
      .padding(.horizontal)
    }
  }
}

struct ProfileRow: View {
  let icon: String
  let title: String
  var subtitle: String? = nil
  
  @AppStorage("systemTheme") private var systemScheme: Bool = false
  
  init(icon: String, title: String, subtitle: String? = nil) {
    self.icon = icon
    self.title = title
    self.subtitle = subtitle
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: icon)
        .foregroundColor(title == "Delete account" ? .red : .gray)
        .imageScale(.large)
        .bold()
        .frame(width: 25)
      
      Text(title)
        .font(.subheadline.bold().monospaced())
        .foregroundStyle(title == "Delete account" ? .red : Color(.label))
      
      Spacer()
      
      if let subtitle = subtitle {
        Text(subtitle)
          .foregroundColor(.gray)
          .font(.subheadline.bold())
      }
      
      if title == "Dark Mode" {
        Toggle("", isOn: $systemScheme)
          .padding(.trailing, 2)
          .toggleStyle(SwitchToggleStyle(tint: .green))
      } else {
        Image(systemName: "chevron.right")
          .foregroundColor(title == "Logout" ? .clear : title == "Delete account" ? .clear : .gray)
          .imageScale(.small).bold()
      }
    }
      .padding(.vertical, 12)
      .padding(.horizontal, 5)
  }
}


#Preview {
  ProfileView()
    .environment(SessionManager())
    .environment(AppRouterManager())
}
