//
//  DeparturesView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct DeparturesView: View {
    // Usamos el mismo ViewModel
    @StateObject private var viewModel = FlightsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado de la lista (Igual que Arrivals pero con "Destino")
                HStack {
                    Text("Hora").bold().frame(width: 50, alignment: .leading).padding(.leading, 35)
                    Text("Vuelo").bold().frame(width: 70, alignment: .leading)
                    Text("Destino").bold().frame(maxWidth: .infinity, alignment: .leading)
                    Text("Aerolínea").bold().frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 35)
                }
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(.gray)
                
                if viewModel.isLoading {
                    ProgressView("Buscando salidas...")
                        .frame(maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 10) {
                        Text("⚠️").font(.largeTitle)
                        Text(error)
                            .font(.callout)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                } else {
                    // Lista de salidas
                    List(viewModel.flights) { flight in
                        NavigationLink(destination: FlightDetailView(flight: flight)) {
                            // Usamos rowType: .departures para mostrar el destino
                            FlightRowView(flight: flight, rowType: .departures)
                        }
                    }
                    .refreshable {
                        viewModel.loadDepartures()
                    }
                }
            }
            .navigationTitle("Salidas")
            .onAppear {
                // Llamamos a la función de salidas al cargar la vista
                viewModel.loadDepartures()
            }
        }
    }
}


/*
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

*/
