//
//  BirthdayView.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 27.03.2025.
//

import SwiftUI

struct BirthdayView: View {
  @Bindable var session: SessionManager
  
  @State private var selectedMonth = 1
  @State private var selectedDay = 1
  @State private var selectedYear = 2020
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.bg.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          BackButton()
          
          Text("When is your birthday?")
            .font(.headline.bold().monospaced())
        }
        
        Text("Your birthday will not be shown to the public.")
          .font(.footnote.bold().monospaced())
          .padding(.horizontal, 20)
        
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
        .padding(.horizontal, 20)
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            session.navigate(to: .fillProfile)
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
              )
            ) {
              session.user.birthday = date
            }
            session.navigate(to: .fillProfile)
          } label: {
            Text("Continue")
              .font(.headline.bold().monospaced())
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(Color(.pink)))
              .clipShape(.rect(cornerRadius: 50))
          }
        }
        .padding(.horizontal, 20)
      }
    }
    .foregroundStyle(.white)
    .buttonStyle(.plain)
  }
}

struct CustomDatePicker: View {
  @Binding var selectedMonth: Int
  @Binding var selectedDay: Int
  @Binding var selectedYear: Int
  
  let months = Array(1...12)
  let days = Array(1...31)
  let years = Array(1950...2025)
  
  var body: some View {
    HStack(spacing: 0) {
      Picker(selection: $selectedDay, label: Text("")) {
        ForEach(days, id: \.self) { day in
          Text("\(day)")
            .font(.system(size: day == selectedDay ? 18 : 16, weight: day == selectedDay ? .bold : .regular))
            .foregroundColor(day == selectedDay ? .white : .gray)
        }
      }
      
      Picker(selection: $selectedMonth, label: Text("")) {
        ForEach(months, id: \.self) { month in
          Text(Calendar.current.monthSymbols[month - 1])
            .font(.system(size: month == selectedMonth ? 18 : 16, weight: month == selectedMonth ? .bold : .regular).monospaced())
            .foregroundColor(month == selectedMonth ? .white : .gray)
        }
      }
      .frame(width: 150)
      
      Picker(selection: $selectedYear, label: Text("")) {
        ForEach(years, id: \.self) { year in
          Text("\(year)")
            .font(.system(size: year == selectedYear ? 18 : 16, weight: year == selectedYear ? .bold : .regular))
            .foregroundColor(year == selectedYear ? .white : .gray)
        }
      }
    }
    .pickerStyle(.wheel)
  }
}

#Preview {
  BirthdayView(session: .init())
    .environment(SessionManager())
}
