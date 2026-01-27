//
//  PhotoPickerViewModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 28.03.2025.
//

import SwiftUI
import PhotosUI

@Observable
final class FillProfileViewModel {
  
  var image: UIImage? = nil
  var email: String = ""
  var fullname: String = ""
  var nickname: String = ""
  var address: String = ""
  var phoneNumber: String = ""
  
  var selectionImage: PhotosPickerItem? = nil {
    didSet {
      Task {
        await self.getImageFromPhotoPicker(from: selectionImage)
      }
    }
  }
  
  func saveUserToFileManager(_ user: UserModel, isAuthorized: Bool) {
    if let image = image {
      user.avatar = imageToBase64(image) ?? ""
    }
    
    user.fullName = fullname
    user.nickname = nickname
    user.email = email
    user.phone = phoneNumber
    user.address = address
    
    UserManager.shared.saveUser(user)
  }
  
  func getImageFromPhotoPicker(from selection: PhotosPickerItem?) async {
    guard let selection else { return }
    
    Task {
      if let data = try? await selection.loadTransferable(type: Data.self) {
        if let uiImage = UIImage(data: data) {
          self.image = uiImage
        }
      }
    }
  }
  
  func checkingCredentials() -> Bool {
    if !email.isEmpty && !fullname.isEmpty && !nickname.isEmpty && !phoneNumber.isEmpty {
      return true
    }
    
    return false
  }
  
  private func imageToBase64(_ image: UIImage) -> String? {
      guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
      return imageData.base64EncodedString()
  }
}
