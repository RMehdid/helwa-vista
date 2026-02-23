//
//  City.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation

struct City: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
