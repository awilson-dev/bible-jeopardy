//
//  Bible_JeopardyApp.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/22/22.
//

import SwiftUI

@main
struct Bible_JeopardyApp: App {
    @Environment(\.openWindow) var openWindow
    @StateObject var settings = GameSettings.shared
    
    var body: some Scene {
        WindowGroup("Bible Jeopardy") {
            ContentView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        openWindow(id: "game_manager")
                    }
                }
        }
        
<<<<<<< HEAD
#if os(macOS)
        Window("Game Manager", id: "game_manager") {
            ManagerContentView()
        }
#endif
=======
        Window("Game Manager", id: "game_manager") {
            ManagerContentView()
        }
>>>>>>> main
        
        Settings {
            VStack {
                Picker("Number of Categories", selection: $settings.categoryCount) {
                    ForEach(4 ..< 7) { n in
                        Text("\(n)")
                            .tag(n)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Toggle("Hidden Treasure", isOn: $settings.hiddenTreasureEnabled)
                    .toggleStyle(.switch)
                    .padding()
            }
            .frame(width: 300, height: 200)
        }
    }
}
