//
//  Player.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import Foundation

struct Player: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let position: String
    let pointsLast3: Double
    let seasonAvg: Double
}
