//
//  Untitled.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 9/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSignUp = false

    var body: some View {
        VStack(spacing: 20) {
            Image("FantasyFootballAppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Login")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .bold()

            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Login") {
                authViewModel.signIn(email: email, password: password)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(email.isEmpty || password.isEmpty)
            .opacity(email.isEmpty || password.isEmpty ? 0.5 : 1)
            
            if let errorMessage = authViewModel.errorMessage {
                withAnimation {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }

            Button("Don’t have an account? Sign up") {
                showSignUp = true
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.appBackground)
        .sheet(isPresented: $showSignUp) {
            SignUpView()
                .environmentObject(authViewModel)
        }
    }
}

#Preview {
    LoginView()
}
