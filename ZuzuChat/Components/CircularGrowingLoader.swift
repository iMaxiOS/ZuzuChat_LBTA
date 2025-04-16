//
//  CircularGrowingLoader.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 26.03.2025.
//

import SwiftUI

struct CircularGrowingLoader: View {
  let circleCount = 8
  let duration: TimeInterval = 1.5
  
  var body: some View {
    TimelineView(.animation) { timeline in
      let elapsedTime = timeline.date.timeIntervalSinceReferenceDate
      let progress = elapsedTime.remainder(dividingBy: duration) / duration
      let rotationAngle = Angle(degrees: progress * 360)
      
      ZStack {
        ForEach(0..<circleCount, id: \.self) { index in
          Circle()
            .frame(
              width: size(for: index, progress: progress),
              height: size(for: index, progress: progress)
            )
            .foregroundColor(Color(.pink).opacity(opacity(for: index, progress: progress)))
            .offset(
              x: 15 * cos(angle(for: index)),
              y: 15 * sin(angle(for: index))
            )
        }
      }
      .rotationEffect(rotationAngle)
    }
  }
  
  private func angle(for index: Int) -> CGFloat {
    return CGFloat(index) * (2 * .pi / CGFloat(circleCount))
  }
  
  private func opacity(for index: Int, progress: Double) -> Double {
    let phase = Double(index) / Double(circleCount)
    return 0.3 + 0.7 * cos(2 * .pi * (progress - phase)).magnitude
  }
  
  private func size(for index: Int, progress: Double) -> CGFloat {
    let phase = Double(index) / Double(circleCount)
    return 2 + 5 * cos(2 * .pi * (progress - phase)).magnitude
  }
}

#Preview {
  CircularGrowingLoader()
}
