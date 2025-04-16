//
//  FillProfileView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI
import PhotosUI

struct FillProfileView: View {
  @EnvironmentObject var session: SessionManager
  
  @State var vm = FillProfileViewModel()
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          BackButton()
          
          Text("Fill Your Profile")
            .font(.headline.bold().monospaced())
        }
        
        VStack(spacing: 20) {
          PhotosPicker(selection: $vm.selectionImage) {
            if let image = vm.image {
              Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(.circle)
            } else {
              Image(systemName: "person.fill")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.gray)
                .frame(width: 100, height: 100)
                .offset(y: 20)
            }
          }
          .frame(width: 120, height: 120)
          .background(.grayBlue)
          .clipShape(.circle)
          .buttonStyle(.plain)
          .overlay(alignment: .bottomTrailing) {
            Image(systemName: "square.and.pencil.circle.fill")
              .resizable()
              .renderingMode(.template)
              .foregroundStyle(Color(.pink))
              .frame(width: 30, height: 30)
          }
          
          TextField("", text: $vm.fullname, prompt: Text("Full Name").foregroundStyle(.gray.opacity(0.3)))
            .foregroundStyle(.white)
            .padding()
            .background(Color.grayBlue)
            .clipShape(.rect(cornerRadius: 10))
          
          
          TextField("", text: $vm.nickname, prompt: Text("Nickname").foregroundStyle(.gray.opacity(0.3)))
            .foregroundStyle(.white)
            .padding()
            .background(Color.grayBlue)
            .clipShape(.rect(cornerRadius: 10))
          
          HStack {
            TextField("", text: $vm.email, prompt: Text("Email").foregroundStyle(.gray.opacity(0.3)))
              .foregroundStyle(.white)
              .padding(.vertical)
            Spacer()
            Image(systemName: "envelope.fill")
          }
          .padding(.horizontal)
          .background(Color.grayBlue)
          .clipShape(.rect(cornerRadius: 10))
          
          HStack(spacing: 4) {
            Image(systemName: "flag.fill")
            Image(systemName: "chevron.down")
              .imageScale(.small)
            TextField("", text: $vm.phoneNumber, prompt: Text("Phone Number").foregroundStyle(.gray.opacity(0.3)))
              .foregroundStyle(.white)
              .padding(.vertical)
          }
          .padding(.horizontal)
          .background(.grayBlue)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          
          HStack {
            TextField("", text: $vm.address, prompt: Text("Address (option)").foregroundStyle(.gray.opacity(0.3)))
              .foregroundStyle(.white)
              .padding(.vertical)
            Spacer()
            Image(systemName: "door.garage.closed.trianglebadge.exclamationmark")
          }
          .padding(.horizontal)
          .background(.grayBlue)
          .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundStyle(.gray.opacity(0.3))
        .padding(.horizontal, 20)
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            session.navigate(to: .pinOrForget(type: .otp))
          } label: {
            Text("Skip")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(.grayBlue)
              .clipShape(.rect(cornerRadius: 50))
          }
          
          Button {
            let isValid = vm.checkingCredentials()
            if isValid {
              vm.saveUserToFileManager(session.user, isAuthorized: session.isAuthorized)
              session.navigate(to: .pinOrForget(type: .otp))
            }
          } label: {
            Text("Continue")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(Color(.pink)))
              .clipShape(.rect(cornerRadius: 50))
          }
          .disabled(!vm.checkingCredentials())
        }
        .padding(.horizontal, 20)
      }
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
  }
}

#Preview {
  FillProfileView()
    .environmentObject(SessionManager())
}
