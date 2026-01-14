//
//  AirspaceViewModel.swift
//  GCRadar
//
//  Created by alumno on 14/01/26.
//

import SwiftUI

@MainActor
class AirspaceViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = OpenSkyService()
    
    /// Carga los vuelos que se encuentran dentro del espacio aéreo de Gran Canaria,
    /// usando la API de OpenSky (con caché de 24h en el servicio).
    func loadAirspaceFlights() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedFlights = try await service.fetchFlightsInGCRange()
                // Filtramos por el helper ya existente `isWithinGCRange` por seguridad
                self.flights = fetchedFlights.filter { $0.isWithinGCRange }
                self.isLoading = false
            } catch {
                self.errorMessage = "Error cargando espacio aéreo: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}

