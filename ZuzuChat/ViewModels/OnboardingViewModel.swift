//
//  OnboardingViewModel.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 28.01.2026.
//

import Foundation

@MainActor
@Observable
final class OnboardingViewModel {

  private(set) var draft = UserModel()

  func setEmail(_ email: String) {
    draft.email = email
  }

  func setInterests(_ interests: Set<String>) {
    draft.interests = interests
  }

  func setAbout(_ about: String?) {
    draft.about = about
  }

  func setProfile(birthday: Date?) {
    draft.birthday = birthday
  }

  func setContacts(avatar: String?, fullname: String?, nickname: String?, phone: String?, address: String?) {
    draft.avatar = avatar
    draft.fullName = fullname
    draft.nickname = nickname
    draft.phone = phone
    draft.address = address
  }
}

enum OnboardingError: Error {
  case incompleteData
}

extension OnboardingViewModel {

  func buildUser() throws -> UserModel {
//    guard !draft.email.isEmpty, !draft.fullName.isEmpty else {
//      throw OnboardingError.incompleteData
//    }

    return UserModel(
      id: draft.id,
      email: draft.email,
      isAuthorized: draft.isAuthorized,
      fullName: draft.fullName,
      avatar: draft.avatar,
      interests: draft.interests,
      about: draft.about,
      birthday: draft.birthday,
      nickname: draft.nickname,
      phone: draft.phone,
      address: draft.address
    )
  }
}
