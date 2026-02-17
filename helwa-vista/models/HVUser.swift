//
//  HVUser.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 10.12.25.
//

import Foundation

struct HVUser {
    let id: UUID = UUID()
    let firstname: String
    let lastname: String
    let email: String?
    let pyro: String
    
    static let sampleUser = HVUser(firstname: "Samy", lastname: "Mehdid", email: nil, pyro: pyros.randomElement()!)
    
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
