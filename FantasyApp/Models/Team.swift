//
//  Team.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import Foundation

struct Team: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var playerNames: [String]  // 16 max, references Player.name from PlayerDataService
}
