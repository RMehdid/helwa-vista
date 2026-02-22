//
//  SupabaseManager.swift
//  stampd
//
//  Created by Samy Mehdid on 2/22/26.
//
import Supabase
import Foundation

class SupabaseManager {
    
    let client: SupabaseClient
    
    internal init() {
        guard
            let host = Bundle.main.object(forInfoDictionaryKey: "supabaseURL") as? String,
            let key = Bundle.main.object(forInfoDictionaryKey: "supabaseKey") as? String,
            let url = URL(string: "https://\(host)")
        else {
            fatalError("Missing Supabase configuration")
        }
        
        client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: key,
            options: .init(
                auth: .init(
                    autoRefreshToken: true,
                    emitLocalSessionAsInitialSession: true
                )
            )
        )
    }
}
