//
//  MapView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 09.12.25.
//

import SwiftUI
import _MapKit_SwiftUI

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager.shared
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    var body: some View {
        ZStack(alignment: .top) {
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

#Preview {
    MapView()
}
