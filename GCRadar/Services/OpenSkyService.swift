//
//  OpenSkyService.swift
//  GCRadar
//
//  Created by alumno on 14/01/26.
//

import Foundation

/// Servicio para consultar el estado del espacio aéreo usando la API de OpenSky.
/// Devuelve una lista de `Flight` con información mínima pero suficiente para la vista de espacio aéreo.
class OpenSkyService {
    
    // Bounding box del espacio aéreo de Gran Canaria
    // LATITUDE: 28°46'14.82"N -  26°49'15.43"N
    // LONGITUDE: 16° 0'43.17"W -  14°34'34.02"W
    private let lamin = 26.82095
    private let lamax = 28.77078
    private let lomin = -16.01199
    private let lomax = -14.57612
    
    private let baseUrl = "https://opensky-network.org/api/states/all"
    
    // Claves de caché
    private let cacheKey = "last_api_check_opensky_gc_airspace"
    private let fileName = "cached_opensky_gc_airspace.json"
    
    // MARK: - API Pública
    
    /// Devuelve los vuelos (estados) dentro del bounding box de Gran Canaria,
    /// usando caché de 24h para evitar gastar créditos innecesariamente.
    func fetchFlightsInGCRange() async throws -> [Flight] {
        // 1. Intentar cargar desde caché si no ha pasado un día
        if !shouldRefreshData() {
            if let cached = loadLocalFlights() {
                print("DEBUG: Cargando estados OpenSky desde caché local.")
                return cached
            }
        }
        
        // 2. Si es necesario, hacer la petición a la API
        print("DEBUG: Petición API OpenSky (posible gasto de crédito).")
        
        guard let url = URL(string: "\(baseUrl)?lamin=\(lamin)&lomin=\(lomin)&lamax=\(lamax)&lomax=\(lomax)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let flights = try mapOpenSkyResponseToFlights(data: data)
        
        // 3. Guardar resultados y actualizar fecha
        saveLocalFlights(flights)
        UserDefaults.standard.set(Date(), forKey: cacheKey)
        
        return flights
    }
    
    // MARK: - Parsing de respuesta OpenSky
    
    /// Convierte la respuesta cruda de OpenSky (JSON con `states` como arrays) a `[Flight]`
    private func mapOpenSkyResponseToFlights(data: Data) throws -> [Flight] {
        // Usamos JSONSerialization porque `states` es un array heterogéneo ([Any])
        guard
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let states = jsonObject["states"] as? [[Any]]
        else {
            print("DEBUG: Respuesta OpenSky no tiene el formato esperado.")
            return []
        }
        
        let isoFormatter = ISO8601DateFormatter()
        let now = Date()
        let oneHourLater = now.addingTimeInterval(3600)
        let departureISO = isoFormatter.string(from: now)
        let arrivalISO = isoFormatter.string(from: oneHourLater)
        
        var flights: [Flight] = []
        flights.reserveCapacity(states.count)
        
        for state in states {
            // Documentación OpenSky (índices relevantes):
            // 0: icao24, 1: callsign, 2: origin_country,
            // 5: longitude, 6: latitude, 7: baro_altitude,
            // 9: velocity (m/s)
            
            guard state.count > 10 else { continue }
            
            let icao24 = state[0] as? String ?? "unknown"
            let rawCallsign = state[1] as? String ?? ""
            let callsign = rawCallsign.trimmingCharacters(in: .whitespacesAndNewlines)
            let originCountry = state[2] as? String ?? "Unknown country"
            
            let longitude = state[5] as? Double ?? 0.0
            let latitude = state[6] as? Double ?? 0.0
            let altitude = state[7] as? Double ?? 0.0
            let velocity = state[9] as? Double ?? 0.0
            
            // Convertimos velocidad de m/s a km/h
            let speedKmH = velocity * 3.6
            
            // Construimos el modelo `Flight` con información mínima / sintética.
            let originInfo = Flight.AirportInfo(
                airport: "Desconocido",
                iata: "--",
                gate: nil,
                terminal: nil
            )
            
            let destinationInfo = Flight.AirportInfo(
                airport: "Desconocido",
                iata: "--",
                gate: nil,
                terminal: nil
            )
            
            let liveInfo = Flight.LiveInfo(
                latitude: latitude,
                longitude: longitude,
                altitude: altitude,
                speed: speedKmH
            )
            
            let aircraftInfo = Flight.AircraftInfo(
                model: "Desconocido",
                registration: icao24.uppercased()
            )
            
            let airlineInfo = Flight.AirlineInfo(
                name: originCountry,
                iata: ""
            )
            
            let identifiers = Flight.FlightIdentifiers(
                iata: callsign.isEmpty ? icao24.uppercased() : callsign,
                icao: icao24
            )
            
            let flight = Flight(
                departureTime: departureISO,
                arrivalTime: arrivalISO,
                departureDelay: nil,
                arrivalDelay: nil,
                identifiers: identifiers,
                origin: originInfo,
                destination: destinationInfo,
                live: liveInfo,
                airline: airlineInfo,
                aircraft: aircraftInfo,
                isLive: true
            )
            
            flights.append(flight)
        }
        
        return flights
    }
    
    // MARK: - Gestión de Archivos (Caché)
    
    private func getFileURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }
    
    private func shouldRefreshData() -> Bool {
        guard let lastCheck = UserDefaults.standard.object(forKey: cacheKey) as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastCheck) > (24 * 60 * 60)
    }
    
    private func saveLocalFlights(_ flights: [Flight]) {
        do {
            let data = try JSONEncoder().encode(flights)
            try data.write(to: getFileURL())
        } catch {
            print("Error guardando caché OpenSky: \(error)")
        }
    }
    
    private func loadLocalFlights() -> [Flight]? {
        let url = getFileURL()
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Flight].self, from: data)
        } catch {
            print("Error cargando caché OpenSky: \(error)")
            return nil
        }
    }
}

