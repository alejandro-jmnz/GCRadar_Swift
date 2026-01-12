//
//  ArrirvalsView.swift
//  GCRadar
//
//  Created by alumno on 12/11/25.
//

import SwiftUI

struct ArrivalsView: View {
    // Usamos el ViewModel
    @StateObject private var viewModel = FlightsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado
                HStack {
                    Text("Hora").bold().frame(width: 50, alignment: .leading).padding(.leading, 35)
                    Text("Vuelo").bold().frame(width: 70, alignment: .leading)
                    Text("Origen").bold().frame(maxWidth: .infinity, alignment: .leading)
                    Text("Aerolínea").bold().frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 35)
                }
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(.gray)
                
                if viewModel.isLoading {
                    ProgressView("Buscando vuelos...")
                        .frame(maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    // Lista
                    List(viewModel.flights) { flight in
                        NavigationLink(destination: FlightDetailView(flight: flight)) {
                            // Asumiendo que FlightRowView ya existe y funciona con tu modelo Flight
                            FlightRowView(flight: flight, rowType: .arrivals)
                        }
                    }
                    .refreshable {
                        viewModel.loadDepartures()
                    }
                }
            }
            .navigationTitle("Llegadas")
            .onAppear {
                // Cargar datos al aparecer la vista
                viewModel.loadArrivals()
            }
        }
    }
}


/* VISTA ANTES DE LA API
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
*/
