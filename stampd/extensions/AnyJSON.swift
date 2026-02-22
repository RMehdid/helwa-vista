//
//  AnyJSON.swift
//  stampd
//
//  Created by Samy Mehdid on 2/23/26.
//
import Supabase

extension AnyJSON {
    
    var stringValue: String? {
        switch self {
        case .string(let value):
            return value
        case .bool(let value):
            return String(value)
        default:
            return nil
        }
    }
}
