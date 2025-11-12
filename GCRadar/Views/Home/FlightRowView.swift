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
            if flight.origin.iata == "LPA" {
                Text(flight.departureTime)
            } else if flight.destination.iata == "LPA" {
                Text(flight.arrivalTime)
            } // TODO anadir un else para los que solo sobrevuelan GC
            
            Text(flight.identifiers.iata)
            if flight.origin.iata == "LPA" {
                Text(flight.destination.airport)
                Text(flight.durationString)
            } else if flight.destination.iata == "LPA" {
                Text(flight.origin.airport)
            } // TODO anadir un else para los que solo sobrevuelan GC
            
            CompanyLogo(name: domain(for: flight.airline.name)) // Usamos la funcion para obtener el dominio de la aerolinea y poder pasarlo a la API
        }
        .padding(.vertical, 8)
    }
}

