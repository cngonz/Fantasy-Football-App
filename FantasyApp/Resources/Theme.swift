//
//  Theme.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import SwiftUI

// MARK: - Typography
extension Font {
    static let appLargeTitle = Font.system(size: 32, weight: .bold, design: .rounded)
    static let appTitle = Font.system(size: 22, weight: .bold, design: .rounded)
    static let appHeadline = Font.system(size: 17, weight: .semibold, design: .rounded)
    static let appBody = Font.system(size: 16, weight: .regular)
    static let appCaption = Font.system(size: 13, weight: .medium)
    static let appScore = Font.system(size: 36, weight: .heavy, design: .rounded)
}

// MARK: - Buttons
struct PrimaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.appHeadline)
            .foregroundColor(.black.opacity(0.85))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(isEnabled ? Color.appAccent : Color.appAccent.opacity(0.35))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.appBody.weight(.medium))
            .foregroundColor(.appTextSecondary)
            .padding(.vertical, 10)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}

struct DestructiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.appHeadline)
            .foregroundColor(.appDanger)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}

// MARK: - Card surface
struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color.appCardSurface)
            .cornerRadius(14)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardBackground())
    }
}

// MARK: - Text field
struct AppTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(Color.appCardSurface)
            .foregroundColor(.appTextPrimary)
            .cornerRadius(10)
    }
}

// MARK: - Trade score badge (signature element)
struct ScoreBadge: View {
    let score: Int

    private var tierColor: Color {
        switch score {
        case ..<34: return .appDanger
        case 34...66: return .appAccent
        default: return .appSuccess
        }
    }

    private var tierLabel: String {
        switch score {
        case ..<20: return "GETTING FLEECED"
        case 20..<40: return "LOPSIDED"
        case 40..<60: return "FAIR DEAL"
        case 60..<80: return "GOOD VALUE"
        default: return "HEIST"
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            Text("\(score)")
                .font(.appScore)
                .foregroundColor(.black.opacity(0.85))
            Text(tierLabel)
                .font(.appCaption)
                .foregroundColor(.black.opacity(0.65))
                .tracking(1)
        }
        .frame(width: 140, height: 100)
        .background(tierColor)
        .cornerRadius(16)
    }
}
