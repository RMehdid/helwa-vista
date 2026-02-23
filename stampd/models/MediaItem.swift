//
//  MediaType.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

struct MediaItem: Identifiable, Codable, Equatable {
    let id: UUID
    let url: String
    let type: MediaType
}
