//
//  SignUpView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 9/11/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.appLargeTitle)
                .foregroundColor(.appTextPrimary)

            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(AppTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(AppTextFieldStyle())

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.appDanger)
                    .font(.appCaption)
            }

            Button("Create Account") {
                authViewModel.signUp(email: email, password: password) { success, error in
                    if success {
                        dismiss()
                    } else {
                        errorMessage = error
                    }
                }
            }
            .buttonStyle(PrimaryButtonStyle())

            Button("Go Back") {
                dismiss()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}
