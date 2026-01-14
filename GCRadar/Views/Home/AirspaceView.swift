//
//  AirspaceView.swift
//  GCRadar
//
//  Created by alumno on 17/11/25.
//

import SwiftUI

struct AirspaceView: View {
    @StateObject private var viewModel = AirspaceViewModel()
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
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
                
                // Contenido principal
                if viewModel.isLoading {
                    ProgressView("Cargando espacio aéreo...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 8) {
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            viewModel.loadAirspaceFlights()
                        }
                        .padding(.top, 4)
                    }
                    .padding()
                } else {
                    // Lista de vuelos que sobrevuelan el espacio aéreo de Gran Canaria
                    List(viewModel.flights) { flight in
                        NavigationLink(destination: FlightDetailView(flight: flight)) {
                            FlightRowView(flight: flight, rowType: .airspace, favoritesViewModel: favoritesViewModel)
                        }
                    }
                }
            }
            .navigationTitle(Text("Espacio Aéreo")) // TODO anadir el logo de la app
            .onAppear {
                // Solo cargamos si aún no tenemos datos
                if viewModel.flights.isEmpty {
                    viewModel.loadAirspaceFlights()
                }
            }
        }
    }
}

