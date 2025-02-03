//
//  QuestionnaireView.swift
//  gains
//
//  Created by Elmer Cruz on 2/2/25.
//

import SwiftUI

struct QuestionnaireView: View {
    // An array of questions (or a custom data model if needed)
    let questions = [
        "What is your primary fitness goal?",
        "What secondary fitness goal(s) would you like to include?",
        "How many days per week would you like to work out?",
        "How long should each workout session last?",
        "What type of workouts do you prefer",
        "What is your current fitness level",
        "What is yuour experience level with weight training",
        "How would you describe your strength in key lifts",
        "Do you have any muscle inbalances or weaknesses you want to correct",
        "Where will you be working out",
        "What equipment do you have access to",
        "Would you like body weight only workout options",
        "Are there any muscle groups you want to focus on",
        "Are there any muscle groups you want to avoid or deemphasize",
        "Do you have any past injuries of physical limitations",
        "Do you have any mobility issues",
        "How much variety do you want in your workouts",
        "How intense do you want your workouts to be",
        "Do you prefer progressive overload recommendations",
        "How often should AI adjust your workouts",
        "Would you like AI to recommend warmups and cooldowns",
        "Would you like cardio workouts included",
    ]
    
    // Track the current question index
    @State private var currentQuestionIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color("Background1")
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text(questions[currentQuestionIndex])
                    .font(.title)
                    .padding()
                
                // "Next" button
                Button("Next") {
                    // Move to the next question, wrap around if at the end
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                    } else {
                        // Or handle finishing the questionnaire
                        currentQuestionIndex = 0
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }
}

#Preview {
    QuestionnaireView()
}
