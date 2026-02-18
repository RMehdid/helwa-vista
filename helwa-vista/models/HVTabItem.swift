//
//  HVTabItem.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//
import SwiftUI

enum HVTabItem: Int, CaseIterable {
    case map
    case challenges
    case social

    var title: String {
        switch self {
        case .map: return "Map"
        case .challenges: return "Challenges"
        case .social: return "Social"
        }
    }

    var icon: String {
        switch self {
        case .map: return "map.fill"
        case .challenges: return "gamecontroller.fill"
        case .social: return "person.3.fill"
        }
    }
    
    var view: any View {
        switch self {
        case .map: return MapView()
        case .challenges: return ChallengesView()
        case .social: return SocialView()
        }
    }
}
