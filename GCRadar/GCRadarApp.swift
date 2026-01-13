//
//  GCRadarApp.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI
import FirebaseCore

@main
struct GCRadarApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    init() {
        // Inicializar Firebase
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isAuthenticated {
                    MainTabView(authViewModel: authViewModel, favoritesViewModel: favoritesViewModel)
                        .task {
                            // Cargar favoritos cuando el usuario inicie sesión
                            await favoritesViewModel.loadFavoriteFlightNumbers()
                        }
                } else {
                    AuthRootView(authViewModel: authViewModel)
                }
            }
        }
    }
}
