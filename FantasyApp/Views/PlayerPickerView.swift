//
//  PlayerPickerView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import SwiftUI

struct PlayerPickerView: View {
    @ObservedObject var dataService = PlayerDataService.shared
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    let onSelect: (Player) -> Void
    var restrictedTo: [Player]? = nil

    var filteredPlayers: [Player] {
        let pool = restrictedTo ?? dataService.players
        if searchText.isEmpty { return pool }
        return pool.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                Group {
                    if dataService.isLoading {
                        ProgressView("Loading players…")
                            .tint(.appAccent)
                            .foregroundColor(.appTextSecondary)
                    } else if let error = dataService.loadError {
                        Text(error).foregroundColor(.appDanger).padding()
                    } else {
                        List(filteredPlayers) { player in
                            Button {
                                onSelect(player)
                                dismiss()
                            } label: {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(player.name).font(.appHeadline).foregroundColor(.appTextPrimary)
                                    Text("\(player.position) • Season avg: \(String(format: "%.1f", player.seasonAvg)) pts")
                                        .font(.appCaption)
                                        .foregroundColor(.appTextSecondary)
                                }
                            }
                            .listRowBackground(Color.appCardSurface)
                        }
                        .scrollContentBackground(.hidden)
                        .searchable(text: $searchText, prompt: "Search players")
                    }
                }
            }
            .navigationTitle("Select Player")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.appAccent)
                }
            }
        }
    }
}
