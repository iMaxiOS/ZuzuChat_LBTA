//
//  OnboardingView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

struct OnboardingModel: Hashable {
  var image: String
  let description: String
  
  static let onboardingData: [OnboardingModel] = [
    .init(image: "Illustration 1", description: "Watch interesting video from around the world"),
    .init(image: "Illustration 2", description: "Find your friends and chat with them"),
    .init(image: "Illustration 3", description: "Lets fun with your friends & Zuzu right now")
  ]
}

struct OnboardingView: View {
//  @Environment(AppRouterManager.self) private var router
  @Environment(SessionManager.self) private var session
  
  @State private var onboardingData: [OnboardingModel] = OnboardingModel.onboardingData
  @State private var currentIndex = 0
  @State private var isShowLoader: Bool = false
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      if !isShowLoader {
        LoaderView()
      } else {
        onboardingView
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        isShowLoader = true
      }
    }
  }
}

private extension OnboardingView {
  var onboardingView: some View {
    GeometryReader {
      let size = $0.size
      let offset = -CGFloat(currentIndex) * size.width
      
      HStack(spacing: 0) {
        ForEach(onboardingData, id: \.self) { item in
          VStack(spacing: 16) {
            Spacer()
            
            Image(item.image)
              .resizable()
              .offset(x: offset)
              .animation(.easeIn(duration: 0.4), value: currentIndex)
            
            Text(item.description)
              .font(.largeTitle.bold().monospaced())
              .multilineTextAlignment(.center)
              .foregroundStyle(.white)
              .padding(.horizontal)
              .offset(x: offset)
              .animation(.easeIn(duration: 0.3), value: currentIndex)
            
            Spacer()
            
            HStack {
              ForEach(0..<onboardingData.count, id: \.self) { i in
                RoundedRectangle(cornerRadius: 4)
                  .frame(width: currentIndex == i ? 30 : 8, height: 8)
                  .foregroundStyle(currentIndex == i ? Color(.pink) : .gray)
                  .animation(.easeInOut(duration: 0.3), value: currentIndex)
              }
            }
            
            Button {
              if currentIndex < onboardingData.count - 1 {
                currentIndex += 1
              } else {
                session.onboardingType = .login
              }
            } label: {
              Text(currentIndex < onboardingData.count - 1 ? "Next" : "Get started")
                .font(.subheadline.bold().monospaced())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color(.pink))
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding(20)
            .buttonStyle(.plain)
          }
          .frame(width: size.width, height: size.height)
        }
      }
      .frame(width: size.width * CGFloat(onboardingData.count), alignment: .leading)
    }
  }
}

#Preview {
  OnboardingView()
    .environment(SessionManager())
}
