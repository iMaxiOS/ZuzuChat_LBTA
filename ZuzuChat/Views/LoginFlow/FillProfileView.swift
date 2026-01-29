//
//  FillProfileView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI
import PhotosUI

struct FillProfileView: View {
  @Environment(OnboardingViewModel.self) var onboardingVM
  @Environment(SessionManager.self) private var session
  
  @State var vm = FillProfileViewModel()
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(spacing: 20) {
        title
        pickerPhotoAndFields
        Spacer()
        buttons
      }
    }
  }
}

private extension FillProfileView {
  var title: some View {
    Text("Fill Your Profile")
      .font(.title3.bold().monospaced())
  }
  
  var pickerPhotoAndFields: some View {
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
          .foregroundStyle(.gray)
          .frame(width: 30, height: 30)
      }
      
      TextField("", text: $vm.fullname, prompt: Text("Full Name").foregroundStyle(.white))
        .foregroundStyle(.white)
        .padding()
        .background(Color.grayBlue)
        .clipShape(.rect(cornerRadius: 10))
      
      TextField("", text: $vm.nickname, prompt: Text("Nickname").foregroundStyle(.white))
        .foregroundStyle(.white)
        .padding()
        .background(Color.grayBlue)
        .clipShape(.rect(cornerRadius: 10))
      
      HStack {
        TextField("", text: $vm.email, prompt: Text("Email").foregroundStyle(.white))
          .padding(.vertical)
          .keyboardType(.emailAddress)
        Spacer()
        Image(systemName: "envelope.fill")
      }
      .foregroundStyle(.white)
      .padding(.horizontal)
      .background(Color.grayBlue)
      .clipShape(.rect(cornerRadius: 10))
      
      HStack(spacing: 4) {
        Image(systemName: "flag.fill")
        Image(systemName: "chevron.down")
          .imageScale(.small)
        TextField("", text: $vm.phoneNumber, prompt: Text("Phone Number").foregroundStyle(.white))
          .padding(.vertical)
          .keyboardType(.numberPad)
          .textContentType(.telephoneNumber)
      }
      .foregroundStyle(.white)
      .padding(.horizontal)
      .background(.grayBlue)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      
      HStack {
        TextField("", text: $vm.address, prompt: Text("Address (option)").foregroundStyle(.white))
          .padding(.vertical)
        Spacer()
        Image(systemName: "door.garage.closed.trianglebadge.exclamationmark")
      }
      .foregroundStyle(.white)
      .padding(.horizontal)
      .background(.grayBlue)
      .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .foregroundStyle(.gray.opacity(0.3))
    .padding(.horizontal, 10)
  }
  
  var buttons: some View {
    HStack(spacing: 10) {
      Button {
        session.push(toType: .pinOrForget(type: .otp))
      } label: {
        Text("Skip")
          .font(.headline.bold().monospaced())
          .padding(.vertical, 16)
          .frame(maxWidth: .infinity)
          .background(.grayBlue)
          .clipShape(.rect(cornerRadius: 50))
      }
      
      Button {
        Task {
          let isValid = vm.checkingCredentials()
          
          if isValid {
            if let image = vm.image {
              onboardingVM.setContacts(
                avatar: vm.imageToBase64(image) ?? "",
                fullname: vm.fullname,
                nickname: vm.nickname,
                phone: vm.phoneNumber,
                address: vm.address
              )
            }
            
            session.push(toType: .pinOrForget(type: .otp))
          }
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
    .padding(.horizontal, 10)
    .buttonStyle(.plain)
  }
}

#Preview {
  FillProfileView()
    .environment(SessionManager())
    .environment(OnboardingViewModel())
}
