//
//  RunView.swift
//  gains
//
//  Created by Elmer Cruz on 2/6/25.
//

import  SwiftUI

struct RunView: View {
    var body: some View {
        ZStack {
            Color("Background4")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image("Settings Icon Black")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Spacer()
                    NavigationLink(destination: MonthCalendarView()) {
                        Image("Button (Go Back)")
                    }
                }.padding()
                Image("Your Run")
                    .padding(20)
                Spacer()
                VStack(spacing: 0) {
                    HStack (spacing: 0) {
                        ZStack {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 100)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            VStack {
                                Image("Time_")
                                Text("0:00")
                                    .font(.system(size: 35, weight: .bold, design: .default))
                                    .italic()
                                    .foregroundColor(.white)
                            }
                            
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 100)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                            VStack {
                                Image("Distance_")
                                Text("0 mi")
                                    .font(.system(size: 35, weight: .bold, design: .default))
                                    .italic()
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    HStack (spacing: 0) {
                        ZStack {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 100)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                            VStack {
                                Image("Pace_")
                                Text("0:00 min/mile")
                                    .font(.system(size: 28, weight: .bold, design: .default))
                                    .italic()
                                    .foregroundColor(.white)
                            }
                        }
                        ZStack {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 100)

                                .overlay(
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                            VStack {
                                Image("Calories Burned_")
                                Text("0 cals")
                                    .font(.system(size: 35, weight: .bold, design: .default))
                                    .italic(true)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RunView()
}
