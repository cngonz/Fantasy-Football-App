//
//  TradeEvaluation.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import Foundation

struct TradeSideResult {
    let playerName: String
    let predictedPoints: Double
}

struct TradeEvaluation {
    let sideAGives: [TradeSideResult]
    let sideBGives: [TradeSideResult]

    var sideATotal: Double { sideAGives.reduce(0) { $0 + $1.predictedPoints } }
    var sideBTotal: Double { sideBGives.reduce(0) { $0 + $1.predictedPoints } }

    /// Positive means Side A comes out ahead; negative means Side B does.
    var netDifferential: Double { sideBTotal - sideATotal }

    var verdict: String {
        let diff = abs(netDifferential)
        if diff < 1.0 { return "Fair trade — roughly even value" }
        return netDifferential > 0
            ? "You're winning this trade by \(String(format: "%.1f", diff)) pts"
            : "You're losing this trade by \(String(format: "%.1f", diff)) pts"
    }

    /// 1–100 score. 50 = dead even. 100 = lopsided in your favor. 1 = you got fleeced.
    /// netDifferential = what you receive minus what you give away.
    var score: Int {
        let scaled = 50 + 50 * tanh(netDifferential / 15.0)
        return max(1, min(100, Int(scaled.rounded())))
    }
}
