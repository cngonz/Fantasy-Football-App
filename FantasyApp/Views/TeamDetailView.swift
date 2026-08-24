//
//  TeamDetailView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import SwiftUI

struct TeamDetailView: View {
    let team: Team
    @ObservedObject var dataService = PlayerDataService.shared
    @State private var showTradeAnalyzer = false

    private var rosterPlayers: [Player] {
        dataService.players.filter { team.playerNames.contains($0.name) }
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack {
                List(rosterPlayers) { player in
                    HStack {
                        Text(player.name).foregroundColor(.appTextPrimary).font(.appBody)
                        Spacer()
                        Text(player.position).foregroundColor(.appTextSecondary).font(.appCaption)
                    }
                    .listRowBackground(Color.appCardSurface)
                }
                .scrollContentBackground(.hidden)

                Button("Trade Analyzer") { showTradeAnalyzer = true }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding()
            }
        }
        .navigationTitle(team.name)
        .navigationDestination(isPresented: $showTradeAnalyzer) {
            TradeAnalyzerView(givingPool: rosterPlayers)
        }
    }
}
