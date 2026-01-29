//
//  BirthdayView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI

struct BirthdayView: View {
  @Environment(OnboardingViewModel.self) var onboardingVM
  @Environment(SessionManager.self) private var session
  
  @State private var selectedMonth = 1
  @State private var selectedDay = 1
  @State private var selectedYear = 2020
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(spacing: 20) {
        Text("When is your birthday?")
          .font(.title3.bold().monospaced())
        Text("Your birthday will not be shown to the public.")
          .font(.footnote.bold())
          .padding(.horizontal, 10)
        
        VStack {
          Image(systemName: "birthday.cake.fill")
            .resizable()
            .frame(width: 200, height: 200)
          
          HStack {
            HStack {
              if let date = Calendar.current.date(
                from: DateComponents(
                  year: selectedYear,
                  month: selectedMonth,
                  day: selectedDay
                )
              ) {
                Text(date, style: .date)
              }
            }
            .font(.callout.bold())
            
            Spacer()
            
            Image(systemName: "calendar")
          }
          .padding()
          .background(.grayBlue)
          .clipShape(.rect(cornerRadius: 10))
          .padding(.vertical, 20)
          
          CustomDatePicker(
            selectedMonth: $selectedMonth,
            selectedDay: $selectedDay,
            selectedYear: $selectedYear
          )
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 10)
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            session.push(toType: .fillProfile)
          } label: {
            Text("Skip")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(.grayBlue)
              .clipShape(.rect(cornerRadius: 50))
          }
          
          Button {
            if let date = Calendar.current.date(
              from: DateComponents(
                year: selectedYear,
                month: selectedMonth,
                day: selectedDay
              ))
            {
              onboardingVM.setProfile(birthday: date)
            }
            
            session.push(toType: .fillProfile)
          } label: {
            Text("Continue")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(Color(.pink)))
              .clipShape(.rect(cornerRadius: 50))
          }
        }
        .padding(.horizontal, 10)
      }
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  BirthdayView()
    .environment(SessionManager())
    .environment(OnboardingViewModel())
}
