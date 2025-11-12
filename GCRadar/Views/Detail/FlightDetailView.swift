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
    @State private var isFavorite = false // Controla si es favorito o no
    // TODO favoritos
    
    
    var body: some View {
        ScrollView {
            VStack {
                // 1er recuadro
                HStack {
                    VStack {
                        Image(systemName: "airplane.departure")
                        Text(flight.origin.airport)
                        Text(flight.departureTime)
                    }
                    .padding()
                    VStack {
                        Image(systemName: "airplane")
                        Text(flight.durationString)
                    }
                    .padding()
                    VStack {
                        Image(systemName: "airplane.arrival")
                        Text(flight.destination.airport)
                        Text(flight.arrivalTime)
                    }
                    .padding()
                    
                    Button(action: { // Boton de favoritos
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                    }
                }
                .padding()
                
                // 2o recuadro
                HStack {
                    VStack {
                        Text("Terminal \(flight.origin.terminal ?? "")") // Si es nulo se imprime una cadena vacia
                        Text(" Puerta \(flight.origin.gate ?? "")")
                    }
                    Spacer()
                    VStack {
                        Text("Terminal \(flight.destination.terminal ?? "")")
                        Text(" Puerta \(flight.destination.gate ?? "")")
                    }
                    
                }
                .padding()
                
                // 3er recuadro
                HStack {
                    VStack {
                        Text(flight.identifiers.iata)
                        Text("Numero de vuelo")
                    }
                    Spacer()
                    VStack {
                        Text(flight.aircraft.registration)
                        Text("Matrícula")
                    }
                    CompanyLogo(name: domain(for: flight.airline.name))
                }
                .padding()
                
                // 4o recuadro
                HStack {
                    VStack {
                        Text(flight.aircraft.model)
                        Text("Modelo de aeronave")
                    }
                    Spacer()
                    VStack {
                        Text("\(flight.airline.name) (\(flight.airline.iata))")
                        Text("Aerolinea")
                    }
                }
                .padding()
                
                // 5o recuadro
                HStack {
                    VStack {
                        Text(String(format: "%.0f", flight.live.altitude)) // Formato sin decimales
                        Text("Altura (m)")
                    }
                    Spacer()
                    VStack {
                        Text(String(format: "%.0f", flight.live.speed))
                        Text("Velocidad (km/h)")
                    }
                }
                .padding()
                
                
                
                // Selector simple de dos botones
                HStack(spacing: 12) { // TODO hacerlo como en el diseno
                    Button(action: { showMap = false}) {
                        Text("Aeronave") // TODO anadir vista de carrousel con fotos de la aeronave
                    }
                    
                    Button(action: { showMap = true}) {
                        Text("Mapa") // TODO anadir vista del mapa con la aeronave en tiempo real
                    }
                }
            }
                
        }
    }
}

