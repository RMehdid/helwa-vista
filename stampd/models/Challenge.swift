//
//  Challenge.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation

struct Challenge: Identifiable, Codable, Equatable {
    let id: Int64
    let title: String
    let description: String
    let cityId: UUID
    let startDate: Date
    let endDate: Date
    let xpReward: Int
    let difficulty: Int
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case cityId = "city_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case xpReward = "xp_reward"
        case difficulty
        case isActive = "is_active"
    }
}
