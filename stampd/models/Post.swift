//
//  Post.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation

struct Post: Identifiable, Codable, Equatable {
    let id: UUID
    let createdAt: Date
    let userId: UUID?
    let xpEarned: Int?
    var likesCount: Int
    let isVerified: Bool?
    let cityId: UUID
    let challengeId: Int64
    
    var media: [MediaItem]
    
    var user: HVUser?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case userId = "user_id"
        case xpEarned = "xp_earned"
        case likesCount = "likes_count"
        case isVerified = "is_verified"
        case cityId = "city_id"
        case media = "media_urls"
        case challengeId = "challenge_id"
    }
    
    var isLiked: Bool = false
    var isBookmarked: Bool = false
    var isReposted: Bool = false
}
