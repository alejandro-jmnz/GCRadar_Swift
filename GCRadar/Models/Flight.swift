//
//  Flight.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import Foundation

struct Flight: Identifiable, Codable {
    struct AirportInfo: Codable {
        let airport: String
        let iata: String
        let gate: String?
        let terminal: String?
    }
    
    struct FlightIdentifiers: Codable {
        let iata: String
        let icao: String // TODO Quitarlo
    }
    
    struct LiveInfo: Codable {
        let latitude: Double
        let longitude: Double
        let altitude: Double
        let speed: Double
    }
    
    struct AircraftInfo: Codable {
        let model: String
        let registration: String // Matricula
    }
    
    struct AirlineInfo: Codable {
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
    let isLive: Bool
}



// MARK: - Computed Properties

import Foundation

import Foundation

extension Flight {
    
    var duration: TimeInterval? {
        // Parser para la fecha completa que viene de la API
        let isoFormatter = ISO8601DateFormatter()
        // Opciones para asegurar compatibilidad
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let departureDate = isoFormatter.date(from: departureTime),
              let arrivalDate = isoFormatter.date(from: arrivalTime) else {
            return nil
        }
        
        return arrivalDate.timeIntervalSince(departureDate)
    }
    
    // Devuelve la duración formateada como "3h 15m"
    var durationString: String {
        guard let duration = duration else { return "N/A" }
        let totalMinutes = Int(duration / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }
    
    // Convertimos el String ISO de la API a un objeto Date real
    private var departureDateObject: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime] // Soporta el formato estándar de la API
        return formatter.date(from: departureTime)
    }
    
    private var arrivalDateObject: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: arrivalTime)
    }
    
    // Propiedad pública para mostrar solo la hora en la lista (HH:mm)
    var departureTimeFormatted: String {
        guard let date = departureDateObject else { return "--:--" }
        return date.formatted(date: .omitted, time: .shortened) // Ejemplo: "14:30"
    }
    
    // Propiedad pública para mostrar solo la hora de llegada
    var arrivalTimeFormatted: String {
        guard let date = arrivalDateObject else { return "--:--" }
        return date.formatted(date: .omitted, time: .shortened)
    }
    
    // Formateador para mostrar solo la hora en el detalle
    func timeOnly(from isoString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoString) else { return "--:--" }
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "HH:mm"
        return displayFormatter.string(from: date)
    }
    
    var arrivalDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: arrivalTime)
    }

    var departureDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: departureTime)
    }
}

/*
 extension Flight {
    /*var duration: TimeInterval? {
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
    }*/
    
    var duration: TimeInterval? {
        // Parser para la fecha completa que viene de la API
        let isoFormatter = ISO8601DateFormatter()
        // Opciones para asegurar compatibilidad
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let departureDate = isoFormatter.date(from: departureTime),
              let arrivalDate = isoFormatter.date(from: arrivalTime) else {
            return nil
        }
        
        return arrivalDate.timeIntervalSince(departureDate)
    }
    
    var departureTimeFormatted: String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: departureTime) else { return departureTime }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "HH:mm" // Ahora sí, solo hora y minuto para mostrar
        return displayFormatter.string(from: date)
    }
    
    // Devuelve la duración formateada como "3h 15m"
    var durationString: String {
        guard let duration = duration else { return "N/A" }
        let totalMinutes = Int(duration / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }
}*/
