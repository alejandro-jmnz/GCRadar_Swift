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
    
    var body: some View {
        
        // Vista con barra inferior para poder seleccionar distintas vistas secundarias (Salidas, llegadas..)
        TabView {
            DeparturesView()
                .tabItem {
                    Label("Salidas", systemImage: "airplane.departure")
                }
            
            ArrivalsView()
                .tabItem {
                    Label("Llegadas", systemImage: "airplane.arrival")
                }
            
            AirspaceView()
                .tabItem {
                    Label("Espacio Aéreo", systemImage: "airplane")
                }
            FavouritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }
            
            ProfileView(authViewModel: authViewModel)
                .tabItem {
                    Label("Perfil", systemImage: "person.circle")
                }
        }
    }
}


#Preview {
    MainTabView(authViewModel: AuthViewModel())
}
