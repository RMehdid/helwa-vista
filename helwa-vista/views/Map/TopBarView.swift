//
//  TopBarView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 17.02.26.
//
import SwiftUI

extension MapView {
    struct TopBarView: View {
        @State private var isSearching = false
        @State private var searchText = ""
        @FocusState private var isTextFieldFocused: Bool
        
        var body: some View {
            ZStack(alignment: .top) {
                if isSearching {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture {
                            collapseSearch()
                        }
                }
                
                HStack(spacing: 12) {
                    
                    MyPyro(pyro: HVUser.sampleUser.pyro)
                        .frame(width: 48, height: 48)
                    
                    if !isSearching {
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Text("Berlin")
                                .font(.headline)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "cloud.sun.fill")
                                    .foregroundColor(.orange)
                                Text("18°C")
                                    .font(.subheadline)
                            }
                        }
                        .transition(.opacity)
                        
                        Spacer()
                    }
                    
                    ZStack {
                        HStack(spacing: 8) {
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18, weight: .semibold))
                            
                            if isSearching {
                                TextField("Search...", text: $searchText)
                                    .textFieldStyle(.plain)
                                    .focused($isTextFieldFocused)
                                    .transition(.opacity)
                                    .onAppear {
                                        isTextFieldFocused = true
                                    }
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: isSearching ? 16 : 20)
                            .fill(Color(.systemGray6))
                            .frame(height: 40)
                        )
                    }
                    .frame(maxWidth: isSearching ? .infinity : 40, alignment: .trailing)
                    .onTapGesture {
                        if !isSearching {
                            isSearching = true
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea(edges: .top)
                }
                .overlay(
                    Divider(),
                    alignment: .bottom
                )
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isSearching)
        }
        
        private func collapseSearch() {
            isTextFieldFocused = false
            searchText = ""
            isSearching = false
        }
    }
}

#Preview {
    MapView.TopBarView()
}
