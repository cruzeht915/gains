//
//  MonthCalendarView.swift
//  gains
//
//  Created by Elmer Cruz on 2/4/25.
//

import SwiftUI

struct MonthCalendarView: View {
    var body: some View {
        ZStack {
            Color("Background2")   // Background color
                .ignoresSafeArea()
            VStack {
                Text("2025")
                    .font(.system(size: 32, weight: .bold, design: .default))
                Text("February")
                    .font(.system(size: 24, weight: .medium, design: .default))
            }
        }
    }
}
#Preview {
    MonthCalendarView()
}
