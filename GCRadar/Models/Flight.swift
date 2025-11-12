//
//  Flight.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import Foundation

struct Flight: Identifiable {
    struct AirportInfo {
        let airport: String
        let iata: String
        let gate: String?
        let terminal: String?
    }
    
    struct FlightIdentifiers {
        let iata: String
        let icao: String // TODO Quitarlo
    }
    
    struct LiveInfo {
        let latitude: Double
        let longitude: Double
        let altitude: Double
        let speed: Double
    }
    
    struct AircraftInfo {
        let model: String
        let registration: String // Matricula
    }
    
    struct AirlineInfo {
        let name: String
        let iata: String
    }
    
    let id = UUID()
    let departureTime: String
    let arrivalTime: String
    let departureDelay: Int?
    let arrivalDelay: Int?
    let identifiers: FlightIdentifiers
    let origin: AirportInfo
    let destination: AirportInfo
    let live: LiveInfo
    let airline: AirlineInfo
    let aircraft: AircraftInfo
}



// MARK: - Computed Properties
extension Flight {
    var duration: TimeInterval? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // importante: evita errores con zonas horarias
        
        guard let departureDate = formatter.date(from: departureTime),
              let arrivalDate = formatter.date(from: arrivalTime) else {
            return nil
        }
        
        var duration = arrivalDate.timeIntervalSince(departureDate)
        
        // Si la llegada es el día siguiente (por ejemplo, 23:00 → 02:00)
        if duration < 0 {
            duration += 24 * 60 * 60
        }
        
        return duration
    }
    
    // Devuelve la duración formateada como "3h 15m"
    var durationString: String {
        guard let duration = duration else { return "N/A" }
        let totalMinutes = Int(duration / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }
}
