//
//  CreateTeamView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 10/28/25.
//

import SwiftUI

struct CreateTeamView: View {
    @Environment(\.dismiss) var dismiss
    @State private var teamName = ""
    @State private var roster: [Player] = []
    @State private var showPicker = false
    @State private var saveError: String?
    @State private var isSaving = false

    private let rosterSize = 16

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                TextField("Team Name", text: $teamName)
                    .textFieldStyle(AppTextFieldStyle())
                    .padding(.horizontal)

                Text("\(roster.count)/\(rosterSize) players")
                    .font(.appCaption)
                    .foregroundColor(.appTextSecondary)

                List {
                    ForEach(roster) { player in
                        HStack {
                            Text(player.name).foregroundColor(.appTextPrimary).font(.appBody)
                            Spacer()
                            Text(player.position).foregroundColor(.appTextSecondary).font(.appCaption)
                            Button {
                                roster.removeAll { $0.id == player.id }
                            } label: {
                                Image(systemName: "xmark.circle.fill").foregroundColor(.appDanger)
                            }
                            .buttonStyle(.plain)
                        }
                        .listRowBackground(Color.appCardSurface)
                    }

                    if roster.count < rosterSize {
                        Button {
                            showPicker = true
                        } label: {
                            Label("Add Player", systemImage: "plus.circle.fill")
                                .foregroundColor(.appAccent)
                        }
                        .listRowBackground(Color.appCardSurface)
                    }
                }
                .scrollContentBackground(.hidden)

                if let saveError {
                    Text(saveError).foregroundColor(.appDanger).font(.appCaption)
                }

                Button(isSaving ? "Saving…" : "Save Team") {
                    save()
                }
                .buttonStyle(PrimaryButtonStyle(isEnabled: canSave))
                .disabled(!canSave || isSaving)
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Create Team")
        .sheet(isPresented: $showPicker) {
            PlayerPickerView { player in
                if !roster.contains(player) {
                    roster.append(player)
                }
            }
        }
    }

    private var canSave: Bool {
        !teamName.trimmingCharacters(in: .whitespaces).isEmpty && roster.count == rosterSize
    }

    private func save() {
        isSaving = true
        saveError = nil
        let team = Team(name: teamName, playerNames: roster.map(\.name))
        TeamService.shared.saveTeam(team) { success, error in
            isSaving = false
            if success {
                dismiss()
            } else {
                saveError = error
            }
        }
    }
}
