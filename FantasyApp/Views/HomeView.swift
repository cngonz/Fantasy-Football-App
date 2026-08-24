//
//  HomeView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 9/11/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showTeam = false
    @State private var showCreateTeam = false
    @State private var showTradeAnalyzer = false
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(spacing: 14) {
                    Spacer()

                    Image("FantasyFootballAppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)

                    Spacer()

                    Button("View My Teams") { showTeam = true }
                        .buttonStyle(PrimaryButtonStyle())

                    Button("Create a Team") { showCreateTeam = true }
                        .buttonStyle(PrimaryButtonStyle())

                    Button("Trade Analyzer") { showTradeAnalyzer = true }
                        .buttonStyle(PrimaryButtonStyle())

                    Spacer()
                }
                .padding(.horizontal, 32)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.appAccent)
                            .font(.title2)
                    }
                }
            }
            .navigationDestination(isPresented: $showSettings) { SettingsView() }
            .navigationDestination(isPresented: $showTeam) { TeamView() }
            .navigationDestination(isPresented: $showCreateTeam) { CreateTeamView() }
            .navigationDestination(isPresented: $showTradeAnalyzer) { TradeAnalyzerView() }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
