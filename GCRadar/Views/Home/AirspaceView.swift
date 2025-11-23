//
//  AirspaceView.swift
//  GCRadar
//
//  Created by alumno on 17/11/25.
//

import SwiftUI

struct AirspaceView: View {
    // Modelo de prueba mientras no haya una API conectada
    let flights = FlightsMockData.flights
    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado de la lista
                HStack {
                    // TODO Anadir estilos
                    Text("N° de vuelo")
                    Text("Origen")
                    Text("Destino")
                    Text("Aerolínea")
                }
                
                // Lista
                List(flights.filter { $0.isWithinGCRange }) { flight in // Muestra los vuelos que sobrevuelan el espacio aereo de Gran Canaria
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRowView(flight: flight, rowType: .airspace)
                    }
                }
            }
            .navigationTitle(Text("Espacio Aéreo")) // TODO anadir el logo de la app
        }
    }
}


#Preview {
    AirspaceView()
}
