//
//  ContentView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 08.12.25.
//

import MapKit
import SwiftUI

struct ContentView: View {

    @State private var selection: HVTabItem = .map

    var body: some View {

        ZStack(alignment: .bottom) {
            CustomTabBar(selection: $selection)
        }
    }
}

#Preview {
    ContentView()
}
