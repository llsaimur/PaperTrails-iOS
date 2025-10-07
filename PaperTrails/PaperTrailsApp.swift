//
//  PaperTrailsApp.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 9/30/25.
//

import SwiftUI

@main
struct PaperTrailApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(authViewModel)
        }
    }
}



