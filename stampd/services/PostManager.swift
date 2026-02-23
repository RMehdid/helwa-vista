//
//  PostsManager.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation
import Supabase

final class PostManager: SupabaseManager {
    
    private let table = "posts"
    
    static let shared = PostManager()
    
    private override init() {
        super.init()
    }
}

// MARK: - CREATE
extension PostManager {
    
    func createPost(_ post: Post) async throws -> Post {
        let response: Post = try await client
            .from(table)
            .insert(post)
            .select()
            .single()
            .execute()
            .value
        
        return response
    }
}

// MARK: GET Best-Likes Posts
extension PostManager {
    
    func fetchMostLikedPosts(
        limit: Int = 20
    ) async throws -> [Post] {
        
        let response: [Post] = try await client.from(table).select()
            .order("likes_count", ascending: false)
            .limit(limit)
            .execute()
            .value
        
        return response
    }
}

// MARK: GET Friends Posts
extension PostManager {
    
    func fetchFriendsPosts(
        friendIds: [UUID],
        limit: Int
    ) async throws -> [Post] {
        
        guard !friendIds.isEmpty else { return [] }
        
        let response: [Post] = try await client
            .from(table)
            .select()
            .in("user_id", values: friendIds)
            .order("created_at", ascending: false)
            .limit(limit)
            .execute()
            .value
        
        return response
    }
}

// MARK: - GET By City
extension PostManager {
    
    func fetchPosts(for cityId: UUID) async throws -> [Post] {
        let response: [Post] = try await client
            .from(table)
            .select()
            .eq("city_id", value: cityId)
            .execute()
            .value
        
        return response
    }
}

// MARK: - GET By Challenge
//extension PostManager {
//    
//    func fetchPosts(forChallenge challengeId: Int64) async throws -> [Post] {
//        let response: [Post] = try await client
//            .from(table)
//            .select()
//            .eq("challenge_id", value: challengeId)
//            .execute()
//            .value
//        
//        return response
//    }
//}

// MARK: - UPDATE Verificatino
extension PostManager {
    
    func updateVerification(
        postId: UUID,
        isVerified: Bool
    ) async throws {
        try await client
            .from(table)
            .update(["is_verified": isVerified])
            .eq("id", value: postId)
            .execute()
    }
}

// MARK: - DELETE
extension PostManager {
    
    func deletePost(id: UUID) async throws {
        try await client
            .from(table)
            .delete()
            .eq("id", value: id)
            .execute()
    }
}

// MARK: - INCREMENT LIKE
extension PostManager {
    func incrementLikes(postId: UUID) async throws -> Int {
        let response: [Int] = try await client
            .rpc("increment_likes", params: ["post_id": postId])
            .execute()
            .value

        return response.first ?? 0
    }
}
