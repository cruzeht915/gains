//
//  HeatmapView.swift
//  gains
//
//  Created by Elmer Cruz on 2/5/25.
//
import SwiftUI

public struct HeatmapView: View {
    //pulled from database for each user
    @State private var personalMuscleUse: [String: Int] = ["chest":3, "frontDelts":4 , "bis":4, "abs":2, "obliques":2, "quads":1, "adductors":1, "forearms":4, "traps":0, "lats":0, "rhombs":0, "erectors":0, "tris":3, "calves":2, "hams":1, "glutes":1, "abductors":1, "rearDelts":0]
    private var frontMuscles: [String] = ["chest", "frontDelts", "bis", "abs", "obliques", "quads", "adductors", "forearms"]
    private var rearMuscles: [String] = ["traps", "lats", "rhombs", "erectors", "tris", "calves", "hams", "glutes", "abductors", "rearDelts"]
    private var muscleWork: [String] = ["Underworked", "Moderately Worked", "Balanced", "Overworked"];
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image("Settings Icon")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Spacer()
                    NavigationLink(destination: MonthCalendarView()) {
                        Image("Button (Go Back)")
                    }
                }.padding()
                Image("Heat map")
                    .padding(20)
                HStack {
                    ZStack {
                        Image("frontMuscles")
                            .resizable()
                            .scaledToFit()
                        ForEach(frontMuscles.filter {personalMuscleUse[$0]! > 0}, id: \.self) { muscle in
                            if let value = personalMuscleUse[muscle] {
                                Image("\(muscle)\(value)")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                        }
                            
                        
                    }
                    ZStack {
                        Image("rearMuscles")
                            .resizable()
                            .scaledToFit()
                        ForEach(rearMuscles.filter {personalMuscleUse[$0]! > 0}, id: \.self) { muscle in
                            if let value = personalMuscleUse[muscle] {
                                Image("\(muscle)\(value)")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                        }
                    }
                }
                
                HStack{
                    ForEach(1...4, id: \.self){index in
                        Rectangle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("MColor\(index)"))
                                .cornerRadius(4)
                        Text("\(muscleWork[index-1])")
                            .foregroundColor(.white)
                            .font(.caption)
                        
                        
                    }
                }.padding(.vertical)
                
                Text("Summmary:...")
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

#Preview {
    HeatmapView()
}
