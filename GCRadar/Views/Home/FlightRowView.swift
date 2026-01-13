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
    let rowType: FlightRowType
    let favoritesViewModel: FavoritesViewModel?
    
    init(flight: Flight, rowType: FlightRowType, favoritesViewModel: FavoritesViewModel? = nil) {
        self.flight = flight
        self.rowType = rowType
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) { // Añadido spacing y alineación
            
            switch rowType {
            case .departures: // Salidas desde GC
                // 1. Hora
                Text(flight.departureTimeFormatted)
                    .font(.subheadline)
                    .bold()
                    .frame(width: 50, alignment: .leading) // Ancho fijo para alinear columna
                
                // 2. Número de vuelo
                Text(flight.identifiers.iata)
                    .font(.subheadline)
                    .frame(width: 70, alignment: .leading)
                
                // 3. Destino (Aeropuerto)
                Text(flight.destination.airport)
                    .font(.subheadline)
                    .lineLimit(1) // Si el nombre es muy largo, lo corta con ...
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            case .arrivals: // Llegadas a GC
                // 1. Hora
                Text(flight.arrivalTimeFormatted) // Usamos la hora formateada
                    .font(.subheadline)
                    .bold()
                    .frame(width: 50, alignment: .leading)
                
                // 2. Número de vuelo
                Text(flight.identifiers.iata)
                    .font(.subheadline)
                    .frame(width: 70, alignment: .leading)
                
                // 3. Origen (Aeropuerto)
                Text(flight.origin.airport)
                    .font(.subheadline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            case .airspace: // Sobrevuelos (menos común en AviationStack free, pero mantenemos la lógica)
                Text(flight.identifiers.iata)
                    .bold()
                    .frame(width: 70, alignment: .leading)
                
                Text(flight.origin.iata) // Usamos código IATA (ej MAD) para ahorrar espacio
                    .frame(width: 50, alignment: .center)
                
                Image(systemName: "arrow.right")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                Text(flight.destination.iata)
                    .frame(width: 50, alignment: .center)
                    
                Spacer() // Empuja el logo al final
            }
            
            // Logo de la aerolínea
            // Asumimos que tu vista CompanyLogo gestiona su propio tamaño,
            // pero le ponemos un frame por si acaso.
            CompanyLogo(name: domain(for: flight.airline.name))
                .frame(width: 30, height: 30)
                .clipShape(Circle()) // Opcional: hacerlo redondo
            
            // Indicador de favorito
            if let favoritesViewModel = favoritesViewModel {
                Button(action: {
                    Task {
                        await favoritesViewModel.toggleFavorite(
                            flight.identifiers.iata,
                            airline: flight.airline.name
                        )
                    }
                }) {
                    Image(systemName: favoritesViewModel.isFavoriteFlight(flight.identifiers.iata) ? "star.fill" : "star")
                        .foregroundColor(favoritesViewModel.isFavoriteFlight(flight.identifiers.iata) ? .yellow : .gray)
                        .font(.system(size: 16))
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, 8)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4) // Un poco de margen lateral
    }
}

/*
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
*/
