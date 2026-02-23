//
//  MediaType.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation

enum MediaType: Codable {
    case image
    case video
}

struct MediaItem: Identifiable, Codable, Equatable {
    let id: UUID
    let url: String
    let type: MediaType
}
