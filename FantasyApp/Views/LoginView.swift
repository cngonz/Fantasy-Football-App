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
                .frame(width: 180, height: 180)

            Text("Welcome Back")
                .font(.appLargeTitle)
                .foregroundColor(.appTextPrimary)

            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(AppTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(AppTextFieldStyle())

            Button("Log In") {
                authViewModel.signIn(email: email, password: password)
            }
            .buttonStyle(PrimaryButtonStyle(isEnabled: !email.isEmpty && !password.isEmpty))
            .disabled(email.isEmpty || password.isEmpty)

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.appDanger)
                    .font(.appCaption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .transition(.opacity)
            }

            Button("Don't have an account? Sign up") {
                showSignUp = true
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding(24)
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
