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
    @ObservedObject var favoritesViewModel: FavoritesViewModel?
    
    var body: some View {
        NavigationView {
            /*
            VStack {
                // Encabezado de la lista
                HStack {
                    // TODO Anadir estilos
                    Text("N° de vuelo")
                    Text("Origen")
                    Text("Destino")
                    Text("Aerolínea")
                }
                */
            
            VStack {
                // Encabezado de la lista
                HStack {
                    Text("N° de vuelo").bold().frame(width: 50, alignment: .leading).padding(.leading, 35)
                    Text("Origen").bold().frame(width: 70, alignment: .leading).padding(.leading, 20)
                    Text("Destino").bold().frame(width: 70, alignment: .leading)
                    Text("Aerolínea").bold().frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 35)
                }
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(.gray)
                // Lista
                List(flights.filter { $0.isWithinGCRange }) { flight in // Muestra los vuelos que sobrevuelan el espacio aereo de Gran Canaria
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRowView(flight: flight, rowType: .airspace, favoritesViewModel: favoritesViewModel)
                    }
                }
            }
            .navigationTitle(Text("Espacio Aéreo")) // TODO anadir el logo de la app
        }
    }
}

