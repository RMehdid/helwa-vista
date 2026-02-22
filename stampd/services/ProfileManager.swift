//
//  ProfileManager.swift
//  stampd
//
//  Created by Samy Mehdid on 2/22/26.
//
import Foundation
import Supabase

final class ProfileManager: SupabaseManager {
    
    static let shared = ProfileManager()
    
    private override init() {
        super.init()
    }
    
    // MARK: - CREAT
    func createProfile(userId: UUID, firstname: String, lastname: String) async throws {
        
        let existing: [HVUser] = try await client
            .from("profiles")
            .select()
            .eq("user_id", value: userId)
            .execute()
            .value
        
        if !existing.isEmpty {
            return
        }
        
        let profile = HVUser(
            id: UUID(),
            user_id: userId,
            firstname: firstname,
            lastname: lastname,
            pyro: "Default",
            points: 0
        )
        
        try await client
            .from("profiles")
            .insert(profile)
            .execute()
    }
    
    // MARK: - READ
    func fetchProfile(userId: UUID) async throws -> HVUser {
        
        let response: [HVUser] = try await client
            .from("profiles")
            .select()
            .eq("user_id", value: userId)
            .execute()
            .value
        
        guard let profile = response.first else {
            throw HVError.notFound
        }
        
        return profile
    }
    
    // MARK: - UPDATE
    func updateProfile(_ profile: HVUser) async throws {
        
        try await client
            .from("profiles")
            .update(profile)
            .eq("user_id", value: profile.user_id)
            .execute()
    }
}
