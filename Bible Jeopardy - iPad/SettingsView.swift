//
//  SettingsView.swift
//  Bible Jeopardy (iPad)
//
//  Created by Allen Wilson on 5/7/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var settings = GameSettings.shared
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Done") {
                    dismiss()
                }
                .foregroundStyle(.accent)
                .brightness(0.1)
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
            
            Spacer()
            
            Picker("Number of Categories", selection: $settings.categoryCount) {
                ForEach(4 ..< 7) { n in
                    Text("\(n)")
                        .tag(n)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer()
            
            Toggle("Hidden Treasure", isOn: $settings.hiddenTreasureEnabled)
                .toggleStyle(.switch)
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .padding()
        }
        .frame(width: 350, height: 200)
        .padding()
        .preferredColorScheme(.dark)
        .background(Color(white: 0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SettingsView()
}
