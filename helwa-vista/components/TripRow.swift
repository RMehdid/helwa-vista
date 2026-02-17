//
//  TripRow.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 12.12.25.
//

import SwiftUI

struct TripRow: View {
    
    let trip: HVTrip
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            HStack {
                VStack(alignment: .leading){
                    Text(trip.durationTitle)
                        .font(.headline)
                    
                    HStack(spacing: 8){
                        
                        Rectangle()
                            .frame(width: 3)
                            .foregroundColor(.gray)
                            .cornerRadius(1)
                        
                        VStack(alignment: .leading){
                            
                            Text(trip.daysTitle)
                                .font(.subheadline)
                            
                            Text(trip.nightsTitle)
                                .font(.subheadline)
                            
                            Text(trip.spotsTitle)
                                .font(.subheadline)
                        }
                        .opacity(0.7)
                    }
                }
                
                Spacer()
            }
            .padding()
            
            Image(trip.image)
                .resizable()
                .scaledToFill()
                .frame(width: 148)
                .clipShape(Parallelogram())
                .offset(x: 5, y: 20)
            
        }
        .background(Color.creamWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    TripRow(trip: HVTrip.sampleTrip)
        .frame(height: 120)
        .padding(.horizontal, 24)
}
