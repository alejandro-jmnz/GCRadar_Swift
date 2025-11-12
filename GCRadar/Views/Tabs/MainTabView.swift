//
//  MainTabView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//


// PANTALLA PRINCIPAL

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DeparturesView()
                .tabItem {
                    Label("Salidas", systemImage: "airplane.departure")
                }
            
            ArrivalsView()
                .tabItem {
                    Label("Llegadas", systemImage: "airplane.arrival")
                }
            
            // TODO poner las otras vistas
        }
    }
}


#Preview {
    MainTabView()
}
