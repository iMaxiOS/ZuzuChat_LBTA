//
//  CustomDatePicker.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 28.01.2026.
//

import SwiftUI

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
            .foregroundColor(.secondary)
        }
      }
      
      Picker(selection: $selectedMonth, label: Text("")) {
        ForEach(months, id: \.self) { month in
          Text(Calendar.current.monthSymbols[month - 1])
            .font(.system(size: month == selectedMonth ? 18 : 16, weight: month == selectedMonth ? .bold : .regular).monospaced())
            .foregroundColor(.secondary)
        }
      }
      .frame(width: 150)
      
      Picker(selection: $selectedYear, label: Text("")) {
        ForEach(years, id: \.self) { year in
          Text("\(year)")
            .font(.system(size: year == selectedYear ? 18 : 16, weight: year == selectedYear ? .bold : .regular))
            .foregroundColor(.secondary)
        }
      }
    }
    .pickerStyle(.wheel)
  }
}
