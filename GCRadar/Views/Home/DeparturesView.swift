//
//  DeparturesView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct DeparturesView: View {
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
                    Text("Destino")
                    Text("Aerolínea")
                }
                
                // Lista
                List(flights.filter { $0.origin.iata == "LPA" }) { flight in // Muestra los vuelos con origen en Gran Canaria
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRowView(flight: flight, rowType: .departures)
                    }
                }

            }
            .navigationTitle(Text("Salidas")) // TODO anadir el logo de la app
        }
    }
    
    
}

#Preview {
    DeparturesView()
}
