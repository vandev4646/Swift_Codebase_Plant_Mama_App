//
//  AuthenticationView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/3/26.
//


import SwiftUI

struct AuthenticationView: View {
    @StateObject private var authManager = AuthManager()
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUpMode = false // Toggle between Login and Account Creation
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("MenuBackground")
                    .resizable()
                    .modifier(BackgroundStyle())
                    .ignoresSafeArea(.all)
                
                // Logged-out Forms Area
                VStack(spacing: 16) {
                    Text(isSignUpMode ? "Create New Account" : "Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)
                    
                    TextField("Email Address", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    if let errorMsg = authManager.authError {
                        Text(errorMsg)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Primary Action Button
                    Button(action: {
                        Task {
                            if isSignUpMode {
                                await authManager.signUpWithEmail(email: email, password: password)
                            } else {
                                await authManager.loginWithEmail(email: email, password: password)
                            }
                        }
                    }) {
                        Text(isSignUpMode ? "Sign Up" : "Log In")
                            .frame(maxWidth: .infinity)
                            .bold()
                            .foregroundColor(.black)
                            .frame(height: 50)
                            .background(.dotBrown)
                            .cornerRadius(12)
                    }
                    .padding(.top, 10)
                    
                    // Splitter Layout
                    HStack {
                        VStack { Divider() }
                        Text("or").foregroundColor(.gray).font(.footnote)
                        VStack { Divider() }
                    }
                    .padding(.vertical, 10)
                    
                    // Google Authentication Hook
                    Button(action: {
                        Task { await authManager.signInWithGoogle() }
                    }) {
                        HStack {
                            Image(systemName: "globe") // Replace with a Google logo asset later
                            Text("Continue with Google")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                    }
                    .buttonStyle(.bordered)
                    .tint(.gray)
                    
                    // Switch between Sign Up / Login Screen
                    Button(action: { isSignUpMode.toggle() }) {
                        Text(isSignUpMode ? "Already have an account? Log In" : "Don't have an account? Sign Up")
                            .font(.footnote)
                            .foregroundColor(.dotBrown)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: 340)
                
                
            }
            .navigationBarHidden(true)
                    
                        
                    
                }
            }
        }
    

