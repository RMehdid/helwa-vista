//
//  HVError.swift
//  stampd
//
//  Created by Samy Mehdid on 2/21/26.
//

import Foundation

enum HVError: LocalizedError {
    case networkError
    case invalidCredentials
    case decodingFailed
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network connection failed. Please try again."
        case .invalidCredentials:
            return "Invalid email or password."
        case .decodingFailed:
            return "Something went wrong while processing data."
        case .custom(let message):
            return message
        }
    }
}
