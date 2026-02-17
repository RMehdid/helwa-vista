//
//  ContentView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 08.12.25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                // Show user location on the map
                if let userLocation = locationManager.userLocation {
                    Annotation("", coordinate: userLocation) {
                        ZStack {
                            Circle()
                                .fill(.blue.opacity(0.3))
                                .frame(width: 32, height: 32)
                            Circle()
                                .fill(.blue)
                                .frame(width: 16, height: 16)
                            Circle()
                                .stroke(.white, lineWidth: 2)
                                .frame(width: 16, height: 16)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Smarty")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        centerOnUserLocation()
                    }) {
                        Image(systemName: "location.fill")
                            .foregroundStyle(locationManager.userLocation != nil ? .blue : .gray)
                    }
                    .disabled(locationManager.userLocation == nil)
                }
            }
            .onChange(of: locationManager.userLocation) { oldValue, newValue in
                if let newLocation = newValue {
                    // Automatically center on user location when first obtained
                    withAnimation {
                        cameraPosition = .region(
                            MKCoordinateRegion(
                                center: newLocation,
                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            )
                        )
                    }
                }
            }
            .overlay {
                if locationManager.isLoading {
                    ProgressView("Getting location...")
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    private func centerOnUserLocation() {
        guard let userLocation = locationManager.userLocation else { return }
        
        withAnimation {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: userLocation,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
