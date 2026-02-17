//
//  TabView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 06.02.26.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selection: HVTabItem

    var body: some View {
        HStack {
            ForEach(HVTabItem.allCases, id: \.self) { tab in
                tabButton(tab)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
        .padding()
        .shadow(radius: 5)
    }

    private func tabButton(_ tab: HVTabItem) -> some View {
        Button {
            withAnimation(.spring()) {
                selection = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 20))
                Text(tab.title)
                    .font(.caption)
            }
            .foregroundStyle(selection == tab ? .blue : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CustomTabBar(selection: .constant(.map))
}
