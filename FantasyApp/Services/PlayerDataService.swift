//
//  PlayerDataService.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import Foundation

final class PlayerDataService: ObservableObject {
    static let shared = PlayerDataService()

    @Published private(set) var players: [Player] = []
    @Published private(set) var isLoading = false
    @Published var loadError: String?

    private init() {
        loadPlayers()
    }

    func loadPlayers() {
        isLoading = true
        loadError = nil

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }

            guard let url = Bundle.main.url(forResource: "weekly_player_stats_offense", withExtension: "csv") else {
                DispatchQueue.main.async {
                    self.loadError = "Could not find weekly_player_stats_offense.csv in the app bundle."
                    self.isLoading = false
                }
                return
            }

            do {
                let csvString = try String(contentsOf: url, encoding: .utf8)
                let parsed = Self.parse(csvString)
                DispatchQueue.main.async {
                    self.players = parsed
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.loadError = "Failed to read CSV: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }

    private struct WeeklyRow {
        let name: String
        let season: Int
        let week: Int
        let position: String
        let points: Double
    }

    private static func parse(_ csv: String) -> [Player] {
        var lines = csv.components(separatedBy: .newlines)
        guard !lines.isEmpty else { return [] }
        let header = lines.removeFirst().components(separatedBy: ",")

        guard
            let nameIdx = header.firstIndex(of: "player_name"),
            let seasonIdx = header.firstIndex(of: "season"),
            let weekIdx = header.firstIndex(of: "week"),
            let positionIdx = header.firstIndex(of: "position"),
            let pointsIdx = header.firstIndex(of: "fantasy_points_ppr")
        else {
            return []
        }

        var rows: [WeeklyRow] = []
        for line in lines {
            guard !line.isEmpty else { continue }
            let cols = line.components(separatedBy: ",")
            guard cols.count > max(nameIdx, seasonIdx, weekIdx, positionIdx, pointsIdx) else { continue }
            guard
                let season = Int(cols[seasonIdx]),
                let week = Int(cols[weekIdx]),
                let points = Double(cols[pointsIdx])
            else { continue }
            rows.append(WeeklyRow(name: cols[nameIdx], season: season, week: week, position: cols[positionIdx], points: points))
        }

        let grouped = Dictionary(grouping: rows, by: { $0.name })

        var result: [Player] = []
        for (name, playerRows) in grouped {
            let sorted = playerRows.sorted { ($0.season, $0.week) < ($1.season, $1.week) }
            guard let latest = sorted.last else { continue }

            let last3 = sorted.suffix(3)
            let pointsLast3 = last3.map(\.points).reduce(0, +) / Double(last3.count)

            let currentSeasonRows = sorted.filter { $0.season == latest.season }
            let seasonAvg = currentSeasonRows.map(\.points).reduce(0, +) / Double(currentSeasonRows.count)

            result.append(Player(name: name, position: latest.position, pointsLast3: pointsLast3, seasonAvg: seasonAvg))
        }

        return result.sorted { $0.name < $1.name }
    }
}
