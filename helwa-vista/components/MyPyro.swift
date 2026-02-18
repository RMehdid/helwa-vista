//
//  MyPyro.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 09.12.25.
//

import SwiftUI

struct MyPyro: View {
    let pyro: String
    
    var body: some View {
        Image(pyro)
            .resizable()
            .scaledToFit()
            .padding(1.5)
            
    }
}

#Preview {
    MyPyro(pyro: "10496320")
}
