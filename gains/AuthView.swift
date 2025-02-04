//
//  AuthView.swift
//  gains
//
//  Created by Elmer Cruz on 1/31/25.
//

import SwiftUI
struct AuthView: View{
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmedPassword: String = ""
    
    @State var showSignUp: Bool = true
    @State var sucessfulLogin: Bool = false
    @State var sucessfulSignUp: Bool = false
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("Background1")   // Background color
                .ignoresSafeArea()
            
            VStack(spacing: 50){
                Image("SIGN UP OR LOG IN")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(40)
                
                
                
                VStack (spacing: 15){
                    HStack {
                        Button (action: {
                            showSignUp = false
                            sucessfulLogin = true}
                        ) {Image("Button (Log In)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            
                        }
                        .navigationDestination(isPresented: $sucessfulLogin) {
                            MonthCalendarView()
                        }
                        
                        Button (action: {
                            showSignUp = true
                            sucessfulSignUp = true
                        }
                        ) {Image("Button (Sign Up)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                        }.navigationDestination(isPresented: $sucessfulSignUp) {
                            QuestionnaireView()
                        }
                        
                    }
                    
                    
                    ZStack{
                        Image("Email")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                        TextField("Email", text: $email)
                            .foregroundColor(.black)
                            .frame(width: 250, height: 50)
                            .disableAutocorrection(true)
                            .offset(x: 0, y: 15)
                    }
                    
                    ZStack {
                        Image("Password")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                        TextField("Password", text: $password)
                            .foregroundColor(.black)
                            .frame(width: 250, height: 50)
                            .disableAutocorrection(true)
                            .offset(x: 0, y: 15)
                    }
                    
                    if showSignUp {
                        ZStack {
                            Image("Confirm Password")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 70)
                            TextField("Password", text: $confirmedPassword)
                                .foregroundColor(.black)
                                .frame(width: 250, height: 50)
                                .disableAutocorrection(true)
                                .offset(x: 0, y: 15)
                        }
                    }
                    
                    
                }
                
                VStack {
                    Image("Button (Continue with Apple)")
                    Image("Button (Continue with Google)")
                }
            }.padding()
        }
    }
}

#Preview {
    AuthView()
}
