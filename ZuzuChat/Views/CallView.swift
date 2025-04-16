//
//  CallView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI

struct CallView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Image(.man)
        .resizable()
        .scaledToFill()
        .frame(width: 150, height: 200)
        .clipShape(.rect(cornerRadius: 15))
        .padding(.bottom, 140)
        .padding(.trailing, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .shadow(radius: 10)
      
      Button {
        dismiss.callAsFunction()
      } label: {
        Image(systemName: "xmark")
          .foregroundStyle(.white)
          .font(.title2.bold())
          .padding(25)
      }
      .padding(.top, 40)
      .padding(.trailing, 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
      
      
      ZStack {
        VisualEffectBlur(blurStyle: .systemMaterialDark)
        
        HStack(spacing: 12) {
          Button {} label: {
            Image(systemName: "ellipsis.message")
              .frame(width: 20, height: 20)
              .padding(15)
              .background(VisualEffectBlur(blurStyle: .systemChromeMaterialDark))
              .clipShape(.circle)
          }
          Button {} label: {
            Image(systemName: "video.slash")
              .frame(width: 20, height: 20)
              .padding(15)
              .background(VisualEffectBlur(blurStyle: .systemChromeMaterialDark))
              .clipShape(.circle)
          }
          Button {
            dismiss.callAsFunction()
          } label: {
            Image(systemName: "phone.down.fill")
              .padding(25)
              .background(LinearGradient(colors: [Color(.systemRed), Color(.pink)], startPoint: .topLeading, endPoint: .bottomTrailing))
              .background(VisualEffectBlur(blurStyle: .systemChromeMaterialDark))
              .clipShape(.circle)
          }
          Button {} label: {
            Image(systemName: "rectangle.on.rectangle")
              .frame(width: 20, height: 20)
              .padding(15)
              .background(VisualEffectBlur(blurStyle: .systemChromeMaterialDark))
              .clipShape(.circle)
          }
          Button {} label: {
            Image(systemName: "applepencil.adapter.usb.c")
              .frame(width: 20, height: 20)
              .padding(15)
              .background(VisualEffectBlur(blurStyle: .systemChromeMaterialDark))
              .clipShape(.circle)
          }
        }
        .foregroundStyle(.white)
      }
      .frame(height: 90)
      .clipShape(.capsule)
      .padding(.horizontal, 20)
      .padding(.bottom, 30)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    .background(
        Image(.girl)
          .resizable()
          .scaledToFill()
    )
    .ignoresSafeArea()
  }
}

#Preview {
  CallView()
}
