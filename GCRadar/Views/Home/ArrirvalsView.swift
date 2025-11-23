//
//  ArrirvalsView.swift
//  GCRadar
//
//  Created by alumno on 12/11/25.
//

import SwiftUI

struct ArrivalsView: View {
    // Modelo de prueba mientras no haya una API conectada
    let flights = FlightsMockData.flights

    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado de la lista
                HStack {
                    Text("Hora")
                    // TODO Anadir estilos
                    Text("N° de vuelo")
                    Text("Origen")
                    Text("Aerolínea")
                }
                
                // Lista
                List(flights.filter { $0.destination.iata == "LPA" }) { flight in // Muestra los vuelos con destino en Gran Canaria
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRowView(flight: flight, rowType: .arrivals)
                    }
                }
            }
            .navigationTitle(Text("Llegadas")) // TODO anadir el logo de la app
        }
    }
    
    
}

#Preview {
    DeparturesView()
}
