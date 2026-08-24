//
//  AppInfoView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import SwiftUI

struct AppInfoView: View {
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    private var build: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Image("FantasyFootballAppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 24)

                    VStack(spacing: 4) {
                        Text("Fantasy Football")
                            .font(.appHeadline)
                            .foregroundColor(.appTextPrimary)
                        Text("Version \(version) (\(build))")
                            .font(.appCaption)
                            .foregroundColor(.appTextSecondary)
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        InfoRow(title: "About", text: "Build your fantasy roster, track your teams, and evaluate trades using a predictive scoring model.")
                        InfoRow(title: "Trade Analyzer", text: "Trade scores are estimates based on a predictive model and recent player stats. They're a helpful gut-check, not a guarantee of future performance.")
                        InfoRow(title: "Data", text: "Player statistics are sourced from a weekly NFL offensive performance dataset via Kaggle.")
                        InfoRow(title: "Contact", text: "Questions or feedback: cn.gonzalez@ufl.edu")
                    }
                    .padding(.horizontal, 24)

                    
                }
            }
        }
        .navigationTitle("App Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InfoRow: View {
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.appHeadline)
                .foregroundColor(.appTextPrimary)
            Text(text)
                .font(.appBody)
                .foregroundColor(.appTextSecondary)
        }
    }
}

#Preview {
    NavigationStack {
        AppInfoView()
    }
}
