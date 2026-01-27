//
//  CallListView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.01.2026.
//

import SwiftUI

struct CallListView: View {
  @State private var isShowCallView: Bool = false
  
  var body: some View {
    ZStack {
      Color.bg.ignoresSafeArea()
      
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .leading) {
          ForEach(0..<20) { index in
            VStack(spacing: 5) {
              HStack(spacing: 16) {
                Image(index % 2 == 0 ? .thor: .girl)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 50, height: 50)
                  .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 5) {
                  Text(index % 2 == 0 ? "+4 466 695 04 93" : "+6 222 695 11 77")
                    .font(.body)
                  Text(index % 2 == 0 ? "FaceTime" : "Phone")
                    .font(.footnote)
                }
                
                Spacer()
                
                Button{
                  isShowCallView.toggle()
                } label : {
                  Image(systemName: index % 2 == 0 ? "phone.fill" : "video.fill")
                    .padding()
                    .foregroundStyle(.blue)
                    .background(.gray.opacity(0.1))
                    .clipShape(.circle)
                }
              }
              .padding(.vertical, 10)
              
              RoundedRectangle(cornerRadius: 1)
                .frame(height: 1)
                .foregroundStyle(.gray.opacity(0.5))
                .padding(.leading, 68)
            }
          }
        }
        .padding(.horizontal, 10)
      }
      .sheet(isPresented: $isShowCallView) {
        CallView()
      }
    }
  }
}

#Preview {
  CallListView()
}
