//
//  FlightDetailView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct FlightDetailView: View {
    let flight: Flight
    @State private var showMap = false // Controla si muestra el mapa o no
    // TODO mapa
    
    var body: some View {
        ScrollView {
            VStack {
                // Cabecera basica
                HStack {
                    VStack {
                        Text("Origen: \(flight.origin)")
                        Text("Destino: \(flight.destination)")
                    }
                    Spacer()
                    Image(systemName: "star") // Icono de favoritos
                }
                .padding()
                
                // Selector simple de dos botones
                HStack(spacing: 12) {
                    Button(action: { showMap = false}) {
                        Text("Aeronave")
                    }
                }
            }
                
        }
    }
}

