//
//  DeparturesView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct DeparturesView: View {
    // Modelo de prueba mientras no haya una API conectada
    let flights: [Flight] = [
        Flight(
            departureTime: "05:30",
            arrivalTime: "08:45",
            departureDelay: 5,
            arrivalDelay: 0,
            identifiers: .init(iata: "IB3830", icao: "IBE3830"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B12", terminal: "B"),
            destination: .init(airport: "Madrid-Barajas (MAD)", iata: "MAD", gate: "J24", terminal: "4S"),
            live: .init(latitude: 27.9319, longitude: -15.3866, altitude: 0.0, speed: 0.0),
            airline: .init(name: "Iberia", iata: "IB"),
            aircraft: .init(model: "Airbus A321neo", registration: "EC-NAA")
        ),
        Flight(
            departureTime: "06:10",
            arrivalTime: "08:15",
            departureDelay: 0,
            arrivalDelay: 2,
            identifiers: .init(iata: "NT202", icao: "IBB202"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C05", terminal: "C"),
            destination: .init(airport: "Funchal Madeira (FNC)", iata: "FNC", gate: "A06", terminal: "1"),
            live: .init(latitude: 27.9370, longitude: -15.3875, altitude: 150.0, speed: 210.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-600", registration: "EC-NFT")
        ),
        Flight(
            departureTime: "06:45",
            arrivalTime: "09:55",
            departureDelay: 12,
            arrivalDelay: 15,
            identifiers: .init(iata: "VY3061", icao: "VLG3061"),
            origin: .init(airport: "Barcelona-El Prat (BCN)", iata: "BCN", gate: "D18", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A08", terminal: "A"),
            live: .init(latitude: 35.2140, longitude: -9.7421, altitude: 10350.0, speed: 780.0),
            airline: .init(name: "Vueling", iata: "VY"),
            aircraft: .init(model: "Airbus A320", registration: "EC-MLE")
        ),
        Flight(
            departureTime: "07:20",
            arrivalTime: "11:05",
            departureDelay: 0,
            arrivalDelay: 8,
            identifiers: .init(iata: "U27752", icao: "EZY7752"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C21", terminal: "C"),
            destination: .init(airport: "London Gatwick (LGW)", iata: "LGW", gate: "N12", terminal: "N"),
            live: .init(latitude: 28.4521, longitude: -12.8634, altitude: 11250.0, speed: 800.0),
            airline: .init(name: "easyJet", iata: "U2"),
            aircraft: .init(model: "Airbus A320neo", registration: "G-UZLK")
        )
    ]

    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado de la lista
                HStack {
                    Text("Hora")
                    // TODO Anadir estilos
                    Text("N° de vuelo")
                    Text("Destino")
                    Text("Aerolínea")
                }
                
                // Lista
                List(flights) { flight in
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRowView(flight: flight)
                    }
                }
            }
            .navigationTitle(Text("Salidas")) // TODO Cambiarlo por el logo de la app
        }
    }
    
    
}

#Preview {
    DeparturesView()
}
