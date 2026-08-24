//
//  TradeModelInput.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import Foundation

struct TradeModelInput {
    static let positionCategories = [
        "CB","DE","DT","FB","FS","ILB","K","LS","MLB","NT","OLB","P","QB","RB","SS","TE","WR"
    ]

    static let mean: [Double] = [
        7.97680021039708, 9.405081998748514, 0.00040326115543087577,
        8.766546857192952e-05, 7.013237485754362e-05, 0.012360831068642062,
        0.00019286403085824494, 1.7533093714385905e-05, 1.7533093714385905e-05,
        1.7533093714385905e-05, 1.7533093714385905e-05, 5.259928114315771e-05,
        5.259928114315771e-05, 0.001104584904006312, 0.13130533882703602,
        0.2562110984483212, 0.0002805294994301745, 0.20301569211887438,
        0.39479267116682737
    ]

    static let scale: [Double] = [
        7.353277513604255, 6.558055419059981, 0.020077313960577912,
        0.009362573542435741, 0.008374213772501048, 0.11049000372857398,
        0.013886210221787659, 0.004187217011927614, 0.0041872170119296994,
        0.004187217011931736, 0.004187217011930879, 0.0072523454453560215,
        0.007252345445350113, 0.033216935382358946, 0.33773398825471823,
        0.4365397707885717, 0.0167466654182333, 0.4022441060754599,
        0.4888061148960231
    ]

    static func buildFeatures(pointsLast3: Double, seasonAvg: Double, position: String) -> [Double] {
        var raw = [pointsLast3, seasonAvg]
        for category in positionCategories {
            raw.append(category == position.uppercased() ? 1.0 : 0.0)
        }
        return zip(raw, zip(mean, scale)).map { value, meanScale in
            (value - meanScale.0) / meanScale.1
        }
    }
}
