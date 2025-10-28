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
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Image("FantasyFootballAppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 40)
                    
                    Text("Welcome to Fantasy Football")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: TeamView(), isActive: $showTeam) {
                            HomeButton(label: "View My Team / League") {
                                showTeam = true
                            }
                        }

                        NavigationLink(destination: CreateTeamView(), isActive: $showCreateTeam) {
                            HomeButton(label: "Create a Team") {
                                showCreateTeam = true
                            }
                        }

                    }
                    .padding(.horizontal, 40)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            .navigationDestination(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

struct HomeButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.appAccent)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 4)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
