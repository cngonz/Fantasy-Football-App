//
//  TradeAnalyzerView.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//


import SwiftUI

struct TradeAnalyzerView: View {
    var givingPool: [Player]? = nil
    @State private var givingPlayers: [Player] = []
    @State private var receivingPlayers: [Player] = []
    @State private var showGivingPicker = false
    @State private var showReceivingPicker = false

    var evaluation: TradeEvaluation? {
        guard !givingPlayers.isEmpty || !receivingPlayers.isEmpty else { return nil }

        let giving = givingPlayers.compactMap { player -> TradeSideResult? in
            guard let points = TradeModelService.predictNextWeekPoints(
                pointsLast3: player.pointsLast3, seasonAvg: player.seasonAvg, position: player.position
            ) else { return nil }
            return TradeSideResult(playerName: player.name, predictedPoints: points)
        }

        let receiving = receivingPlayers.compactMap { player -> TradeSideResult? in
            guard let points = TradeModelService.predictNextWeekPoints(
                pointsLast3: player.pointsLast3, seasonAvg: player.seasonAvg, position: player.position
            ) else { return nil }
            return TradeSideResult(playerName: player.name, predictedPoints: points)
        }

        return TradeEvaluation(sideAGives: giving, sideBGives: receiving)
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                HStack(alignment: .top, spacing: 16) {
                    TradeColumnView(title: "Trading Away", players: $givingPlayers) {
                        showGivingPicker = true
                    }
                    TradeColumnView(title: "Receiving", players: $receivingPlayers) {
                        showReceivingPicker = true
                    }
                }
                .padding(.horizontal)

                if let evaluation {
                    VStack(spacing: 10) {
                        ScoreBadge(score: evaluation.score)
                        Text(evaluation.verdict)
                            .font(.appBody)
                            .foregroundColor(.appTextSecondary)
                    }
                    .padding(.top, 8)
                }

                Spacer()
            }
            .padding(.top, 24)
        }
        .sheet(isPresented: $showGivingPicker) {
            PlayerPickerView(onSelect: { player in givingPlayers.append(player) }, restrictedTo: givingPool)
        }
        .sheet(isPresented: $showReceivingPicker) {
            PlayerPickerView { player in receivingPlayers.append(player) }
        }
        .navigationTitle("Trade Analyzer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TradeColumnView: View {
    let title: String
    @Binding var players: [Player]
    let onAdd: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.appCaption)
                .foregroundColor(.appTextSecondary)
                .tracking(0.5)

            ForEach(players) { player in
                HStack {
                    Text(player.name)
                        .font(.appBody)
                        .foregroundColor(.appTextPrimary)
                        .lineLimit(1)
                    Spacer()
                    Button {
                        players.removeAll { $0.id == player.id }
                    } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.appDanger)
                    }
                    .buttonStyle(.plain)
                }
                .padding(10)
                .background(Color.appCardSurface)
                .cornerRadius(10)
            }

            Button(action: onAdd) {
                Label("Add Player", systemImage: "plus.circle.fill")
                    .font(.appCaption)
                    .foregroundColor(.appAccent)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
