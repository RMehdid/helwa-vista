//
//  SearchView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 18.02.26.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .searchable(text: $text)
    }
}

#Preview {
    SearchView()
}
