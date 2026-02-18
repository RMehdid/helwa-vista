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
    case messages
    case profile

    var title: String {
        switch self {
        case .map: return "Map"
        case .challenges: return "Challenges"
        case .social: return "Social"
        case .messages: return "Messages"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .map: return "map.fill"
        case .challenges: return "gamecontroller.fill"
        case .social: return "person.3.fill"
        case .messages: return "person.3.fill"
        case .profile: return "person.3.fill"
        }
    }
    
    var view: any View {
        switch self {
        case .map: return MapView()
        case .challenges: return ChallengesView()
        case .social: return SocialView()
        case .messages: return SocialView()
        case .profile: return SocialView()
        }
    }
}
