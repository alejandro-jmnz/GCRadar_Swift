//
//  MainTabView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//


// PANTALLA PRINCIPAL

import SwiftUI

struct MainTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        // Vista con barra inferior para poder seleccionar distintas vistas secundarias (Salidas, llegadas..)
        TabView {
            DeparturesView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Salidas", systemImage: "airplane.departure")
                }
            
            ArrivalsView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Llegadas", systemImage: "airplane.arrival")
                }
            
            AirspaceView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Espacio Aéreo", systemImage: "airplane")
                }
            FavouritesView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }
            
            ProfileView(authViewModel: authViewModel)
                .tabItem {
                    Label("Perfil", systemImage: "person.circle")
                }
        }
        .overlay(alignment: .topTrailing) {
            Image("GCRadar_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(.top, 8)
                .padding(.trailing, 16)
        }
    }
}


#Preview {
    MainTabView(authViewModel: AuthViewModel(), favoritesViewModel: FavoritesViewModel())
}
