//
//  TradeModelService.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import CoreML

enum TradeModelService {
    /// Predicts next week's PPR fantasy points for one player.
    static func predictNextWeekPoints(pointsLast3: Double, seasonAvg: Double, position: String) -> Double? {
        let features = TradeModelInput.buildFeatures(
            pointsLast3: pointsLast3,
            seasonAvg: seasonAvg,
            position: position
        )

        guard let inputArray = try? MLMultiArray(shape: [1, 19], dataType: .float32) else {
            return nil
        }
        for (i, value) in features.enumerated() {
            inputArray[i] = NSNumber(value: value)
        }

        do {
            let model = try FantasyTradeModel(configuration: MLModelConfiguration())
            let output = try model.prediction(x: inputArray)
            return Double(truncating: output.Identity[0])
        } catch {
            print("Trade model prediction failed: \(error)")
            return nil
        }
    }
}
