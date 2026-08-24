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

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            List {
                Section(header: Text("Account").foregroundColor(.appTextSecondary)) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.appAccent)
                            .font(.system(size: 40))
                        VStack(alignment: .leading) {
                            Text(authViewModel.user?.email ?? "Guest User")
                                .foregroundColor(.appTextPrimary)
                                .font(.appHeadline)
                            Text("Fantasy Football Manager")
                                .foregroundColor(.appTextSecondary)
                                .font(.appCaption)
                        }
                    }
                }
                .listRowBackground(Color.appCardSurface)

                Section(header: Text("Preferences").foregroundColor(.appTextSecondary)) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Enable Notifications", systemImage: "bell.fill")
                            .foregroundColor(.appTextPrimary)
                    }
                }
                .tint(.appAccent)
                .listRowBackground(Color.appCardSurface)

                Section(header: Text("About").foregroundColor(.appTextSecondary)) {
                    NavigationLink(destination: AppInfoView()) {
                        Label("App Info", systemImage: "info.circle.fill")
                            .foregroundColor(.appTextPrimary)
                    }
                }
                .listRowBackground(Color.appCardSurface)

                Section {
                    Button(role: .destructive) {
                        authViewModel.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward.circle.fill")
                            Text("Sign Out")
                        }
                    }
                    .buttonStyle(DestructiveButtonStyle())
                }
                .listRowBackground(Color.appCardSurface)
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
