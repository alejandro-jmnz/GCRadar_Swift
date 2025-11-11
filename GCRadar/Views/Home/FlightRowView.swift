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
            Text(flight.departure_time)
            Text(flight.number)
            Text(flight.destination)
            CompanyLogo(name: domain(for: flight.airline)) // Usamos la funcion para obtener el dominio de la aerolinea y poder pasarlo a la API
        }
        .padding(.vertical, 8)
    }
}

