//
//  DeparturesView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct DeparturesView: View {
    // Modelo de prubea mientras no haya una api conectada
    let flights = [
        Flight(
            departure_time: "05:00",
            arrival_time: "06:10",
            number: "AEA9018",
            origin: "GRAN CANARIA (LPA)",
            destination: "MADRID (MAD)",
            airline: "Binter"
        ),
        Flight(
            departure_time: "05:45",
            arrival_time: "07:00",
            number: "IB3841",
            origin: "GRAN CANARIA (LPA)",
            destination: "BARCELONA (BCN)",
            airline: "Iberia"
        ),
        Flight(
            departure_time: "06:30",
            arrival_time: "08:15",
            number: "FR1234",
            origin: "GRAN CANARIA (LPA)",
            destination: "LONDON (LHR)",
            airline: "Ryanair"
        )
    ]

    
    var body: some View {
        NavigationView {
            List(flights) { flight in
                NavigationLink(destination: FlightDetailView(flight: flight)) {
                    FlightRowView(flight: flight)
                }
            }
            .navigationTitle(Text("Departures"))
        }
    }
    
    
}

#Preview {
    DeparturesView()
}
