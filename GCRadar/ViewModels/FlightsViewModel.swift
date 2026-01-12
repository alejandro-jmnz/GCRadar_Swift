//
//  FlightsViewModel.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI

@MainActor
class FlightsViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = AviationService()
    private var arrivalDateObject: Date?
    private var departureDateObject: Date?

    
    // Carga las llegadas (LPA como destino)
    func loadArrivals() {
        performFetch {
            let flights = try await self.service.fetchArrivalsToLPA()
            return flights.sorted {
                ($0.arrivalDate ?? .distantPast) < ($1.arrivalDate ?? .distantPast)
            }
        }
    }
    
    // Carga las salidas (LPA como origen)
    func loadDepartures() {
        performFetch {
            let flights = try await self.service.fetchDeparturesFromLPA()
            return flights.sorted {
                ($0.departureDate ?? .distantPast) < ($1.departureDate ?? .distantPast)
            }
        }
    }
    
    // Función auxiliar para no repetir código de carga/errores
    private func performFetch(fetcher: @escaping () async throws -> [Flight]) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                self.flights = try await fetcher()
                self.isLoading = false
            } catch {
                self.errorMessage = "Error cargando vuelos: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
