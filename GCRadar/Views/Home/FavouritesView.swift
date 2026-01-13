//
//  FavouritesView.swift
//  GCRadar
//
//  Created by alumno on 17/11/25.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    @StateObject private var arrivalsViewModel = FlightsViewModel()
    @StateObject private var departuresViewModel = FlightsViewModel()
    @State private var isLoading = false
    
    // Vuelos favoritos filtrados
    private var favoriteFlights: [Flight] {
        let allFlights = arrivalsViewModel.flights + departuresViewModel.flights
        return allFlights.filter { flight in
            favoritesViewModel.isFavoriteFlight(flight.identifiers.iata)
        }
        .sorted { ($0.departureDate ?? .distantPast) < ($1.departureDate ?? .distantPast) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado de la lista (similar a AirspaceView)
                HStack {
                    Text("N° de vuelo").bold().frame(width: 50, alignment: .leading).padding(.leading, 35)
                    Text("Origen").bold().frame(width: 70, alignment: .leading).padding(.leading, 20)
                    Text("Destino").bold().frame(width: 70, alignment: .leading)
                    Text("Aerolínea").bold().frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 35)
                }
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(.gray)
                
                if isLoading || arrivalsViewModel.isLoading || departuresViewModel.isLoading || favoritesViewModel.isLoading {
                    ProgressView("Cargando favoritos...")
                        .frame(maxHeight: .infinity)
                } else if favoriteFlights.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "star")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No tienes vuelos favoritos")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Marca vuelos como favoritos usando la estrella en las otras vistas")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    // Lista de vuelos favoritos
                    List(favoriteFlights) { flight in
                        NavigationLink(destination: FlightDetailView(flight: flight)) {
                            // Determinar el tipo de fila basado en si es llegada o salida
                            let rowType: FlightRowType = flight.destination.iata == "LPA" ? .arrivals : .departures
                            FlightRowView(flight: flight, rowType: rowType, favoritesViewModel: favoritesViewModel)
                        }
                    }
                    .refreshable {
                        await loadFavoriteFlights()
                    }
                }
            }
            .navigationTitle("Favoritos")
            .onAppear {
                Task {
                    await loadFavoriteFlights()
                }
            }
        }
    }
    
    private func loadFavoriteFlights() async {
        isLoading = true
        
        // Cargar favoritos del usuario
        await favoritesViewModel.loadFavoriteFlightNumbers()
        
        // Cargar vuelos de arrivals y departures
        arrivalsViewModel.loadArrivals()
        departuresViewModel.loadDepartures()
        
        // Esperar a que terminen de cargar
        while arrivalsViewModel.isLoading || departuresViewModel.isLoading {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 segundos
        }
        
        isLoading = false
    }
}

#Preview {
    FavouritesView(favoritesViewModel: FavoritesViewModel())
}
