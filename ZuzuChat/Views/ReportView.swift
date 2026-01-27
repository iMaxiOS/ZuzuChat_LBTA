//
//  ReportView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 03.04.2025.
//

import SwiftUI

enum ReportReason: String, CaseIterable {
  case none, dangerous, graphic, offensive, mirror, inappropriate, animal, hate, pornograph, intellectual, scam, spam, other
  
  var text: String {
    switch self {
    case .none: return ""
    case .dangerous: return "Dangerous organization/individuals"
    case .offensive: return "Misleading Information"
    case .inappropriate: return "Inappropriate"
    case .graphic: return "Graphic content"
    case .animal: return "Animal Cruelty"
    case .hate: return "Hate Speech"
    case .mirror: return "Mirror Safety"
    case .pornograph: return "Pornograph & Nudity"
    case .intellectual: return "Intelectual"
    case .scam: return "Scam"
    case .spam: return "Spam"
    case .other: return "Other"
    }
  }
}

struct ReportView: View {
  @Environment(\.dismiss) private var dismiss
  
  @State private var selectedReport: ReportReason = .none
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        
        ScrollView {
          VStack(alignment: .leading, spacing: 5) {
            Text("Select a reason")
            
            ForEach(ReportReason.allCases, id: \.rawValue) { item in
              if item != .none {
                Button {
                  selectedReport = item
                } label: {
                  HStack(spacing: 20) {
                    ZStack {
                      Circle()
                        .fill(selectedReport != item ? Color.clear : Color(.pink))
                        .frame(width: 15, height: 15)
                        .overlay {
                          Circle()
                            .stroke(Color(.pink), lineWidth: 3)
                            .frame(width: 22, height: 22)
                        }
                    }
                    Text(item.text)
                  }
                  .padding(.vertical)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .background(.black.opacity(0.0001))
                }
                .padding(.horizontal, 6)
              }
            }
          }
        }
        .padding(.horizontal, 10)
        .font(.footnote.bold().monospaced())
        
        
        HStack(spacing: 10) {
          Button {
            dismiss.callAsFunction()
          } label: {
            Text("Cancel")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(.grayBlue)
              .clipShape(.rect(cornerRadius: 50))
          }
          
          Button {
            
          } label: {
            Text("Submit")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(Color(.pink)))
              .clipShape(.rect(cornerRadius: 50))
          }
        }
        .padding(.horizontal, 10)
      }
      .foregroundStyle(.white)
      .buttonStyle(.plain)
    }
    .navigationTitle(Text("Report"))
    .toolbarVisibility(.hidden, for: .tabBar)
  }
}

#Preview {
  ReportView()
}
