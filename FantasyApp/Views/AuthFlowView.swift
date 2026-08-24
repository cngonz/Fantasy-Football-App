//
//  AuthFlowView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 11/5/25.
//

import SwiftUI

struct AuthFlowView: View {
    @State private var showSignUp = false
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            LoginView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Create Account") {
                            showSignUp = true
                        }
                    }
                }
                .sheet(isPresented: $showSignUp) {
                    SignUpView()
                        .environmentObject(authVM)
                }
                
                .onChange(of: authVM.user != nil) { _, signedIn in
                    if signedIn { showSignUp = false }
                }
        }
    }
}
