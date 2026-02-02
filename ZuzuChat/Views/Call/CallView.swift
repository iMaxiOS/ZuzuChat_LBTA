//
//  CallView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI


struct CallView: View {
  
  @State private var isCalling: Bool = false
  @State private var isHideMe: Bool = false
  @State private var isOnMicro: Bool = false
  @State private var isVolume: Bool = false
  
  var index: Int = 0
  
  var body: some View {
    ZStack {
      photo
      buttonsSection
    }
    .animation(.bouncy, value: isCalling)
    .animation(.bouncy, value: isHideMe)
    .background(
      Image(index % 2 == 0 ? .thor : .girl)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
        .opacity(isHideMe ? 0 : 1)
    )
  }
}

#Preview {
  CallView()
}

private extension CallView {
  var photo: some View {
    Image(.man)
      .resizable()
      .scaledToFill()
      .frame(width: 150, height: 200)
      .clipShape(.rect(cornerRadius: 15))
      .padding(.trailing, 10)
      .padding(.top, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
      .shadow(radius: 10)
      .opacity(isCalling ? 1 : 0)
      .offset(x: isCalling ? 0 : 20)
  }
  
  var buttonsSection: some View {
    ZStack {
      HStack(spacing: 12) {
        Button {} label: {
          Image(systemName: "ellipsis.message")
            .frame(width: 20, height: 20)
            .padding()
            .clipShape(.circle)
            .glassEffect(.clear, in: .circle)
        }
        .opacity(isCalling ? 1 : 0)
        .offset(x: isCalling ? 0 : 5)
        
        Button {
          withAnimation(.easeInOut) {
            isHideMe.toggle()
          }
        } label: {
          Image(systemName: "video.slash")
            .frame(width: 20, height: 20)
            .padding()
            .clipShape(.circle)
            .glassEffect(.clear, in: .circle)
        }
        .opacity(isCalling ? 1 : 0)
        .offset(x: isCalling ? 0 : 5)
        .symbolEffect(.bounce, value: isHideMe)
        
        Button { isCalling.toggle() } label: {
          Image(systemName: isCalling ? "phone.fill" : "phone.down.fill")
            .symbolEffect(.bounce, value: isCalling)
            .padding(30)
            .glassEffect(.clear.tint(!isCalling ? .green : .red), in: .circle)
        }
        
        Button { isOnMicro.toggle() } label: {
          Image(systemName: isOnMicro ? "microphone.slash.fill" : "microphone.fill")
            .frame(width: 20, height: 20)
            .padding()
            .glassEffect(.clear, in: .circle)
            .symbolEffect(.bounce, value: isOnMicro)
        }
        .opacity(isCalling ? 1 : 0)
        .offset(x: isCalling ? 0 : -5)
        
        Button { isVolume.toggle() } label: {
          Image(systemName: isVolume ? "volume.slash.fill" : "speaker.wave.1.fill")
            .frame(width: 20, height: 20)
            .padding()
            .glassEffect(.clear, in: .circle)
        }
        .opacity(isCalling ? 1 : 0)
        .offset(x: isCalling ? 0 : -5)
        .symbolEffect(.bounce, value: isVolume)
      }
      .foregroundStyle(.black)
    }
    .padding(.horizontal, 10)
    .padding(.bottom)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    
  }
}
