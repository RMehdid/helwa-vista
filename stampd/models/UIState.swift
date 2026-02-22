//
//  UIState.swift
//  stampd
//
//  Created by Samy Mehdid on 2/22/26.
//

enum UIState<T> {
    case loading
    case success(T)
    case failure(HVError)
}
