//
//  HVUser.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 10.12.25.
//

import Foundation

struct HVUser: Codable, Identifiable, Equatable {
    
    let id: UUID
    let userId: UUID
    let firstname: String
    let lastname: String
    let pyro: String
    let points: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case firstname
        case lastname
        case pyro
        case points
    }
    
    static let sampleUser = HVUser(id: UUID(), userId: UUID(), firstname: "Samy", lastname: "Mehdid", pyro: pyros.randomElement()!, points: 1450)
    
    static let pyros = [
        "7309694",
        "10491791",
        "10491804",
        "10491810",
        "10496303",
        "10496306",
        "10496316",
        "10496320",
        "11475237",
        "11475242",
        "11475254",
        "11475262"
    ]
}
