//
//  ContentVM.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//
import Combine
internal import Auth

extension HomeView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var state: UIState<HVUser> = .loading
        
        private let profileManager = ProfileManager.shared
        private let auth = AuthManager.shared
        
        func loadProfile() async {
            
            state = .loading
            
            guard let userId = auth.session?.user.id else {
                state = .failure(.unAuthorized)
                return
            }
            
            do {
                let profile = try await profileManager.fetchProfile(userId: userId)
                
                state = .success(profile)
                
            } catch let error as HVError {
                state = .failure(error)
                
            } catch {
                state = .failure(.custom(message: "An unexpected error occured"))
            }
        }
    }
}
