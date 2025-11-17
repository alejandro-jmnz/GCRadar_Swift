//
//  FlightRowView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

enum FlightRowType {
    case departures
    case arrivals
    case airspace
}

struct FlightRowView: View {
    let flight: Flight
    let rowType: FlightRowType // Indica desde que vista se llama a esta vista
    
    var body: some View {
        
        HStack {
            switch rowType {
            case .departures: // Vuelos que salen de GC
                Text(flight.departureTime)
                Text(flight.identifiers.iata)
                Text(flight.destination.airport)
            case .arrivals: // Vuelos que llegan a GC
                Text(flight.arrivalTime)
                Text(flight.identifiers.iata)
                Text(flight.origin.airport)
            case .airspace: // Vuelos que sobrevuelan GC
                Text(flight.identifiers.iata)
                Text(flight.origin.airport)
                Text(flight.destination.airport)
            }
            
            CompanyLogo(name: domain(for: flight.airline.name)) // Usamos la funcion para obtener el dominio de la aerolinea y poder pasarlo a la API
        }
        .padding(.vertical, 8)
    }
}

