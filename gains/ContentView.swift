//
//  ContentView.swift
//  gains
//
//  Created by Julio Rodriguez on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("Background1")   // Background color
                .ignoresSafeArea()
            
            VStack (spacing: 150){
                Image("GIGA GAINS")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                
                Image("Track Your Workouts, Optimize Progress, Achieve Your Fitness Goals With AI")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 90)
            
                Button(action: {
                    print("Hello")
                }) {
                    Image("Button (Get Started)")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(radius: 5)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
