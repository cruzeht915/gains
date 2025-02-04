//
//  QuestionnaireView.swift
//  gains
//
//  Created by Elmer Cruz on 2/2/25.
//

import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let type: QuestionType
    let answerChoices: [String]  // Only used if singleChoice or multipleChoice
}

enum QuestionType {
    case singleChoice
    case multipleChoice
    case textInput
}

struct QuestionnaireView: View {
    // An array of questions (or a custom data model if needed)
    let questions: [Question] = [
        Question(text: "1) Gender:", type: .singleChoice, answerChoices: ["Male", "Female", "Other"]),
        Question(text: "2) What is your primary fitness goal?", type: .singleChoice, answerChoices: ["Build Muscle (Hypertrophy)", "Gain Strength", "Improve Endurance", "Lose Fat / Weight Loss", "General Health & Fitness", "Improve Mobility & Flexibility"]),
        Question(text: "3) What secondary fitness goal(s) would you like to include?", type: .multipleChoice, answerChoices: ["Muscle Gain", "Fat Loss", "Strength Building", "Athletic Performance", "Recovery & Mobility", "Improve Cardiovascular Health"]),
        Question(text: "4) How many days per week would you like to work out?", type: .singleChoice, answerChoices: ["1-2 days", "3-4 days", "5+ days"]),
        Question(text: "5) How long should each workout session last?", type: .singleChoice, answerChoices: ["<30 minutes (Quick workouts)", "30-45 minutes (Balanced)", "45-60 minutes (Standard training session)", "60+ minutes (Longer duration workouts)"]),
        Question(text: "6) What type of workouts do you prefer", type: .multipleChoice, answerChoices: ["Weight Training (Barbells, Dumbbells)", "Bodyweight / Calisthenics", "High-Intensity Interval Training (HIIT)", "Cardio (Running, Cycling, etc.)", "Yoga & Mobility (Flexibility focus)", "Functional Training (e.g., CrossFit, kettlebells)"]),
        Question(text: "7) What is your current fitness level", type: .singleChoice, answerChoices: ["Beginner (New to working out)", "Intermediate (Work out occasionally)", "Advanced (Regularly train with structured workouts)"]),
        Question(text: "8) What is yuour experience level with weight training", type: .singleChoice, answerChoices: ["Never lifted before", "Light experience (some gym experience but inconsistent)", "Moderate experience (consistent training for 6+ months)", "Advanced experience (2+ years of structured training)"]),
        Question(text: "9) How would you describe your strength in key lifts (Optional)", type: .textInput, answerChoices: ["Bench Press (Enter weight in lbs/kg):", "Squat (Enter weight in lbs/kg):", "Deadlift (Enter weight in lbs/kg):"]),
        Question(text: "10) Do you have any muscle inbalances or weaknesses you want to correct", type: .multipleChoice, answerChoices: ["Weak upper body (e.g., chest, arms, shoulders)", "Weak lower body (e.g., legs, glutes)", "Core strength (abs, lower back)", "No specific weaknesses"]),
        Question(text: "11) Where will you be working out", type: .singleChoice, answerChoices: ["Commercial Gym (Access to full equipment)", "Home Gym (Limited equipment)", "Outdoor Workouts (e.g., parks, running trails)", "No Equipment (Bodyweight only)"]),
        Question(text: "12) What equipment do you have access to", type: .multipleChoice, answerChoices: ["Barbells & Plates", "Dumbbells", "Kettlebells", "Resistance Bands", "Machines (Leg press, Lat Pulldown, etc.)", "Pull-Up Bar", "Cardio Machines (Treadmill, Bike, etc.)"]),
        Question(text: "13) Would you like body weight only workout options", type: .singleChoice, answerChoices: ["Yes (Only bodyweight exercises)", "No (Include equipment-based workouts)"]),
        Question(text: "14) Are there any muscle groups you want to focus on", type: .multipleChoice, answerChoices: ["Chest", "Back", "Shoulders", "Arms (Biceps/Triceps)", "Core (Abs, Obliques, Lower Back)", "Legs (Quads, Hamstrings, Glutes, Calves)", "Full-Body Workouts"]),
        Question(text: "15) Are there any muscle groups you want to avoid or deemphasize", type: .multipleChoice, answerChoices: ["Chest", "Back", "Shoulders", "Arms", "Core", "Legs", "None (Train everything equally)"]),
        Question(text: "16) Do you have any past injuries of physical limitations", type: .multipleChoice, answerChoices: ["Knee injuries", "Shoulder injuries", "Back pain", "Joint issues (e.g., wrist, elbow)", "None"]),
        Question(text: "17) Do you have any mobility issues", type: .singleChoice, answerChoices: ["Yes (Limited range of motion)", "No"]),
        Question(text: "18) How much variety do you want in your workouts", type: .singleChoice, answerChoices: ["High variety (new workouts often)", "Medium variety (some changes every week)", "Low variety (repeat the same workouts for consistency)"]),
        Question(text: "19) How intense do you want your workouts to be", type: .singleChoice, answerChoices: ["Light (easy, lower intensity)", "Moderate (challenging but not extreme)", "Intense (max effort, high difficulty)"]),
        Question(text: "20) Do you prefer progressive overload recommendations", type: .singleChoice, answerChoices: ["Yes (Increase weights gradually)", "No (Maintain similar difficulty)", "Not Sure"]),
        Question(text: "21) How often should AI adjust your workouts", type: .singleChoice, answerChoices: ["Every session", "Weekly", "Monthly", "Only when I request changes"]),
        Question(text: "22) Would you like AI to recommend warmups and cooldowns", type: .singleChoice, answerChoices: ["Yes (Pre-set dynamic warm-ups & stretching)", "No"]),
        Question(text: "23) Would you like cardio workouts included", type: .singleChoice, answerChoices: ["Yes, regularly (Cardio-focused plan)", "Occasionally (Mix with strength training)", "No (Strength-only focus)"])
    ]
    
    // Track the current question index
    @State private var currentQuestionIndex: Int = 13
    
    // We'll store user answers in these states:
    // - singleChoiceAnswers: [UUID: String]  (one selected answer per question ID)
    // - multipleChoiceAnswers: [UUID: Set<String>] (multiple selected answers per question ID)
    // - textAnswers: [String: String]
    
    @State private var singleChoiceAnswers: [UUID : String] = [:]
    @State private var multipleChoiceAnswers: [UUID : Set<String>] = [:]
    @State private var textAnswers: [String : String] = [:]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background1")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image("SET YOUR FITNESS GOALS")
                    .padding(.top, 40)
                
                VStack {
                    Text("Question \(currentQuestionIndex+1) of 23")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    // Built-in ProgressView
                    ProgressView(value: Double(currentQuestionIndex+1),
                                 total: Double(questions.count))
                    .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                    .padding(.horizontal)
                    
                    let question = questions[currentQuestionIndex]
                    VStack (alignment: .leading, spacing: 20){
                        Text(question.text)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 13)
                        VStack {
                            switch question.type {
                            case .singleChoice:
                                singleChoiceView(question)
                            case .multipleChoice:
                                multipleChoiceView(question)
                            case .textInput:
                                textInputView(question)
                            }
                        }
                    }.padding(20)
                }
     
           
                
                // "Next" button
                HStack{
                    Button("Back") {
                        // Move to the next question, wrap around if at the end
                        if currentQuestionIndex > 0 {
                            currentQuestionIndex -= 1
                        }
                    }
                    .disabled(currentQuestionIndex == 0)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    
                    Spacer()
                    
                    Button(currentQuestionIndex == questions.count-1 ? "Finish" : "Next") {
                        // Move to the next question, wrap around if at the end
                        if currentQuestionIndex < questions.count-1 {
                            currentQuestionIndex += 1
                        } else {
                            // Or handle finishing the questionnaire
                            print("Finished all questions!")
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                }.padding(.horizontal, 40)
            }
        }
    }
    
    // Single Choice: Only one selected answer
    @ViewBuilder
    private func singleChoiceView(_ question: Question) -> some View {
        let selectedAnswer = singleChoiceAnswers[question.id] ?? ""
        ForEach(question.answerChoices, id: \.self) { choice in
            Button(action: {
                singleChoiceAnswers[question.id] = choice
            }) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: choice == selectedAnswer ? "inset.filled.circle" : "circle")
                                                .foregroundColor(.orange)
                                                .font(.title2)
                    Spacer()
                    Text(choice)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(10)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
            .background(Color.black)
            .cornerRadius(8)
        }
    }
    
    // Multiple Choice: A user can select or deselect multiple answers
    @ViewBuilder
    private func multipleChoiceView(_ question: Question) -> some View {
        let selectedSet = multipleChoiceAnswers[question.id] ?? []
        ForEach(question.answerChoices, id: \.self) { choice in
            Button(action: {
                toggleMultipleChoiceAnswer(question: question, choice: choice)
            }) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: selectedSet.contains(choice) ? "checkmark.square.fill" : "square")
                                                .foregroundColor(.orange)
                                                .font(.title2)
                    Spacer()
                    Text(choice)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(10)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
            .background(Color.black)
            .cornerRadius(8)
        }
    }
    
    @ViewBuilder
    private func textInputView(_ question: Question) -> some View {
        VStack(alignment: .leading, spacing: 10){
            ForEach(question.answerChoices, id:\.self) { toInput in
                Text("\(toInput)")
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .font(.system(size: 16, weight: .bold))
                let binding = Binding<String>(
                    get: {textAnswers[toInput] ?? ""},
                    set: {textAnswers[toInput] = $0}
                )
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 200, height: 50)
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 200, height: 50)
                    TextField("", text: binding)
                        .padding()
                        .frame(width: 190, height: 50)
                }
            }
        }
    }
    
    // For multiple choice, add/remove the selected choice from the set
    private func toggleMultipleChoiceAnswer(question: Question, choice: String) {
        var set = multipleChoiceAnswers[question.id] ?? []
        if set.contains(choice) {
            set.remove(choice)
        } else {
            set.insert(choice)
        }
        multipleChoiceAnswers[question.id] = set
    }
}


#Preview {
    QuestionnaireView()
}
