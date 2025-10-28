//
//  SettingsView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 10/28/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            List {
                // MARK: - Account Section
                Section(header: Text("Account").foregroundColor(.white)) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 40))
                        VStack(alignment: .leading) {
                            Text(authViewModel.userSession?.email ?? "Guest User")
                                .foregroundColor(.white)
                                .font(.headline)
                            Text("Fantasy Football Manager")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                    }
                }
                .listRowBackground(Color.appBackground)

                // MARK: - Preferences Section
                Section(header: Text("Preferences").foregroundColor(.white)) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Enable Notifications", systemImage: "bell.fill")
                    }
                    Toggle(isOn: $darkModeEnabled) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }
                .tint(.blue)
                .listRowBackground(Color.appBackground)

                // MARK: - About Section
                Section(header: Text("About").foregroundColor(.white)) {
                    NavigationLink(destination: Text("Version 1.0.0\n© 2025 FantasyApp Inc.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()) {
                        Label("App Info", systemImage: "info.circle.fill")
                    }
                }
                .listRowBackground(Color.appBackground)

                // MARK: - Sign Out Button
                Section {
                    Button(role: .destructive) {
                        authViewModel.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward.circle.fill")
                            Text("Sign Out")
                        }
                    }
                }
                .listRowBackground(Color.appBackground)
            }
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
