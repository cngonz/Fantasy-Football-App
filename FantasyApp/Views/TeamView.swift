//
//  TeamView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 10/28/25.
//

import SwiftUI

struct TeamView: View {
    @ObservedObject var teamService = TeamService.shared
    @State private var selectedTeam: Team?

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            if teamService.teams.isEmpty {
                Text("No teams yet — create one from the Home screen.")
                    .font(.appBody)
                    .foregroundColor(.appTextSecondary)
                    .padding()
            } else {
                List(teamService.teams) { team in
                    Button {
                        selectedTeam = team
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(team.name).font(.appHeadline).foregroundColor(.appTextPrimary)
                            Text("\(team.playerNames.count) players")
                                .font(.appCaption)
                                .foregroundColor(.appTextSecondary)
                        }
                    }
                    .listRowBackground(Color.appCardSurface)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("My Teams")
        .navigationDestination(item: $selectedTeam) { team in
            TeamDetailView(team: team)
        }
        .onAppear { teamService.startListening() }
    }
}
