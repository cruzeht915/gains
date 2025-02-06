//
//  MonthCalendarView.swift
//  gains
//
//  Created by Elmer Cruz on 2/4/25.
//

import SwiftUI
import UIKit

struct MonthCalendarView: View {
    var body: some View {
        ZStack (alignment: .top) {
            Color("Background2")  // Background color
                .ignoresSafeArea()
            VStack {
                HStack (spacing: 20){
                    Image("Settings Icon")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Spacer()
                    HStack(spacing: 5) {
                        Image("Button (Your Week)")
                            .resizable()
                            .frame(width: 95, height: 37)
                        Image("Button (Run)")
                            .resizable()
                            .frame(width: 60, height: 37)
                        NavigationLink(destination: HeatmapView()){
                            Image("Button (heatmap)")
                                .resizable()
                                .frame(width: 87, height: 39)
                        }
                        
                    }
                }.padding()
                Image("Your Month")
                    .padding(.vertical, 35)
                
                MonthView(year:2025, month:6)
                    .padding()
                
                Text("Split 1")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Split 2")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Split 3")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
        }
    }
}

enum SplitType {
    case split1, split2, split3
}

struct DayInfo: Identifiable {
    let id = UUID()
    let date: Date
    let splitType: SplitType?
}

func generateDaysForMonth(year: Int, month: Int) -> [DayInfo] {
    let calendar = Calendar.current
    
    // Start date for the month
    var components = DateComponents(year: year, month: month, day: 1)
    guard let startOfMonth = calendar.date(from: components) else {
        return []
    }
    
    // Determine the weekday for the 1st (Sunday=1, Monday=2, ... Saturday=7)
    let firstWeekday = calendar.component(.weekday, from: startOfMonth)
    
    // Calculate the number of filler days (1-based, so we need `firstWeekday - 1`)
    let fillerDaysCount = (firstWeekday - 1 + 7) % 7
    
    // Figure out how many days are in this month
    let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
    let numDays = range.count
    
    var days: [DayInfo] = []
    
    // Add filler days
    for _ in 0..<fillerDaysCount {
        days.append(DayInfo(date: Date.distantPast, splitType: nil))  // Ghost/filler cell
    }
    
    // Add actual days of the month
    for day in 1...numDays {
        components.day = day
        if let date = calendar.date(from: components) {
            let splitType: SplitType? = nil
            days.append(DayInfo(date: date, splitType: splitType))
        }
    }
    
    return days
}

struct MonthView: View {
    let year: Int
    let month: Int
    
    // Example: days for the grid
    @State private var days: [DayInfo] = []
    
    // 7 columns for Sunday through Saturday
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 7)
    
    var body: some View {
        VStack (spacing: 1){
            // Month title
            Text("\(monthName(year: year, month: month))")
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding(4)
                .background(Color.orange)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            
            // Weekday headers
            HStack (spacing: 1){
                ForEach(["Sun","M","Tue","W","Thu","F","Sat"], id: \.self) { dayName in
                    Text(dayName)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .padding(.vertical, 2)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                }
            }
            .background(Color.orange)
            
            // The main grid
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(days) { dayInfo in
                    DayCell(dayInfo: dayInfo)
                }
            }
        }
        .onAppear {
            // Generate days or load from a ViewModel:
            days = generateDaysForMonth(year: year, month: month)
        }
    }
    
    func monthName(year: Int, month: Int) -> String {
        // Format “March 2025” or just “March”
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = 1
        
        if let date = Calendar.current.date(from: comps) {
            return formatter.string(from: date)
        } else {
            return "Unknown Month"
        }
    }
}

struct DayCell: View {
    let dayInfo: DayInfo
    
    var body: some View {
        if Calendar.current.isDate(dayInfo.date, inSameDayAs: Date.distantPast) {
            Color.clear  // Blank cell for fillers
                .frame(maxWidth: .infinity, minHeight: 50)
        } else {
            VStack {
                Text(dayNumberString(dayInfo.date))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(0)
            }
            .frame(maxWidth: .infinity, minHeight: 50)  // cell size
            .background(backgroundColor(for: dayInfo.splitType))
            .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
        }
    }
    
    private func dayNumberString(_ date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return "\(day)"
    }
    
    private func backgroundColor(for splitType: SplitType?) -> Color {
        // Match colors:
        switch splitType {
        case .split1: return Color.green.opacity(0.6)   // e.g. mint/teal
        case .split2: return Color.red
        case .split3: return Color.blue
        case nil:     return Color.gray
        }
    }
}


#Preview {
    MonthCalendarView()
}
