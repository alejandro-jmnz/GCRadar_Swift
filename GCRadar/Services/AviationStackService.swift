//
//  AviationStackService.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import Foundation

class AviationService {
    private let apiKey = "946cefca18bc1fe3c48d9c0312537cdd"
    private let baseUrl = "https://api.aviationstack.com/v1/flights"
    
    // Enumeración para diferenciar el tipo de consulta
    enum FlightType: String {
        case arrivals = "arr_iata"
        case departures = "dep_iata"
        
        var cacheKey: String { "last_api_check_lpa_\(self.rawValue)" }
        var fileName: String { "cached_flights_lpa_\(self.rawValue).json" }
    }

    // MARK: - Métodos Principales

    func fetchArrivalsToLPA() async throws -> [Flight] {
        return try await fetchFlights(type: .arrivals)
    }

    func fetchDeparturesFromLPA() async throws -> [Flight] {
        return try await fetchFlights(type: .departures)
    }

    // MARK: - Lógica Genérica de Red y Caché

    private func fetchFlights(type: FlightType) async throws -> [Flight] {
        // 1. Intentar cargar desde caché si no ha pasado un día
        if !shouldRefreshData(for: type) {
            if let cached = loadLocalFlights(type: type) {
                print("DEBUG: Cargando \(type.rawValue) desde caché local.")
                return cached
            }
        }
        
        // 2. Si es necesario, hacer la petición a la API
        print("DEBUG: Petición API para \(type.rawValue) (Gasto de 1 crédito).")
        
        // El parámetro cambia según si es arr_iata (llegadas) o dep_iata (salidas)
        guard let url = URL(string: "\(baseUrl)?access_key=\(apiKey)&\(type.rawValue)=LPA") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(AviationStackResponse.self, from: data)
        let flights = decodedResponse.data.compactMap { mapToDomainModel(apiData: $0) }
        
        // 3. Guardar resultados y actualizar fecha
        saveLocalFlights(flights, type: type)
        UserDefaults.standard.set(Date(), forKey: type.cacheKey)
        
        return flights
    }

    // MARK: - Gestión de Archivos

    private func getFileURL(for type: FlightType) -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(type.fileName)
    }

    private func shouldRefreshData(for type: FlightType) -> Bool {
        guard let lastCheck = UserDefaults.standard.object(forKey: type.cacheKey) as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastCheck) > (24 * 60 * 60)
    }

    private func saveLocalFlights(_ flights: [Flight], type: FlightType) {
        do {
            let data = try JSONEncoder().encode(flights)
            try data.write(to: getFileURL(for: type))
        } catch {
            print("Error guardando caché \(type.rawValue): \(error)")
        }
    }

    private func loadLocalFlights(type: FlightType) -> [Flight]? {
        let url = getFileURL(for: type)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Flight].self, from: data)
        } catch {
            print("Error cargando caché \(type.rawValue): \(error)")
            return nil
        }
    }
    
    
    
    // Esta función traduce el modelo que devuelve de la API al modelo Flight que hemos implementado previo a la API
    private func mapToDomainModel(apiData: ApiFlightData) -> Flight? {
        // Nos aseguramos de que existan los datos mínimos
        guard let departure = apiData.departure,
              let arrival = apiData.arrival,
              let airline = apiData.airline,
              let flightDetails = apiData.flight else {
            return nil
        }
        
        // Construimos tus sub-estructuras
        let originInfo = Flight.AirportInfo(
            airport: departure.airport ?? "Unknown",
            iata: departure.iata ?? "N/A",
            gate: departure.gate,
            terminal: departure.terminal
        )
        
        let destinationInfo = Flight.AirportInfo(
            airport: arrival.airport ?? "Unknown",
            iata: arrival.iata ?? "N/A",
            gate: arrival.gate,
            terminal: arrival.terminal
        )
        
        let hasLiveDetails = apiData.live != nil
            
        let liveInfo = Flight.LiveInfo(
            latitude: apiData.live?.latitude ?? 0.0,
            longitude: apiData.live?.longitude ?? 0.0,
            altitude: apiData.live?.altitude ?? 0.0,
            speed: apiData.live?.speed_horizontal ?? 0.0
        )
        
        let aircraftInfo = Flight.AircraftInfo(
            model: apiData.aircraft?.iata ?? "Unknown", // La API a veces no da el modelo exacto en texto
            registration: apiData.aircraft?.registration ?? "N/A"
        )
        
        let airlineInfo = Flight.AirlineInfo(
            name: airline.name ?? "Unknown Airline",
            iata: airline.iata ?? ""
        )
        
        let identifiers = Flight.FlightIdentifiers(
            iata: flightDetails.iata ?? "",
            icao: flightDetails.icao ?? ""
        )
        
        
        // Devolvemos tu estructura Flight completa
        return Flight(
            departureTime: departure.scheduled ?? "", // La API devuelve ISO string, tu computed property lo manejará si el formato coincide
            arrivalTime: arrival.scheduled ?? "",
            departureDelay: departure.delay,
            arrivalDelay: arrival.delay,
            identifiers: identifiers,
            origin: originInfo,
            destination: destinationInfo,
            live: liveInfo,
            airline: airlineInfo,
            aircraft: aircraftInfo,
            isLive: hasLiveDetails, // Guardamos si los datos son reales o por defecto
        )
    }
}
