//
//  FlightRowView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct FlightRowView: View {
    let flight: Flight
    
    var body: some View {
        HStack {
            Text(flight.departureTime)
            Text(flight.identifiers.iata)
            Text(flight.destination.airport)
            CompanyLogo(name: domain(for: flight.airline.name)) // Usamos la funcion para obtener el dominio de la aerolinea y poder pasarlo a la API
        }
        .padding(.vertical, 8)
    }
}

