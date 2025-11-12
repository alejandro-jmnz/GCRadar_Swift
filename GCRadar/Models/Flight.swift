//
//  Flight.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import Foundation
import CoreLocation

struct AircraftMedia: Identifiable {
    let id = UUID()
    let url: URL
    let caption: String
}

struct Flight: Identifiable {
    let id = UUID()
    let departureTime: String
    let arrivalTime: String
    let number: String
    let origin: String
    let destination: String
    let airline: String
    let duration: String
    let gateOrigin: String
    let gateDestination: String
    let iata: String
    let icao: String
    let aircraftModel: String
    let registration: String
    let country: String
    let altitude: String
    let speed: String
    let coordinate: CLLocationCoordinate2D
    let media: [AircraftMedia]
    
    init(
        departureTime: String,
        arrivalTime: String,
        number: String,
        origin: String,
        destination: String,
        airline: String,
        duration: String,
        gateOrigin: String,
        gateDestination: String,
        iata: String,
        icao: String,
        aircraftModel: String,
        registration: String,
        country: String,
        altitude: String,
        speed: String,
        coordinate: CLLocationCoordinate2D,
        media: [AircraftMedia]
    ) {
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.number = number
        self.origin = origin
        self.destination = destination
        self.airline = airline
        self.duration = duration
        self.gateOrigin = gateOrigin
        self.gateDestination = gateDestination
        self.iata = iata
        self.icao = icao
        self.aircraftModel = aircraftModel
        self.registration = registration
        self.country = country
        self.altitude = altitude
        self.speed = speed
        self.coordinate = coordinate
        self.media = media
    }
    
    init(apiFlight: AviationStackFlight, media: [AircraftMedia]) {
        let departureTime = Flight.formatTime(apiFlight.departure.scheduled ?? apiFlight.departure.estimated)
        let arrivalTime = Flight.formatTime(apiFlight.arrival.scheduled ?? apiFlight.arrival.estimated)
        
        let origin = [
            apiFlight.departure.airport,
            formattedCode(iata: apiFlight.departure.iata, icao: apiFlight.departure.icao)
        ]
            .compactMap { $0 }
            .joined(separator: " ")
        
        let destination = [
            apiFlight.arrival.airport,
            formattedCode(iata: apiFlight.arrival.iata, icao: apiFlight.arrival.icao)
        ]
            .compactMap { $0 }
            .joined(separator: " ")
        
        let gateOrigin = apiFlight.departure.gate ?? "—"
        let gateDestination = apiFlight.arrival.gate ?? "—"
        
        let aircraftModel = apiFlight.aircraft.iata ?? apiFlight.aircraft.icao ?? "—"
        let registration = apiFlight.aircraft.registration ?? "—"
        let airlineName = apiFlight.airline.name ?? "—"
        
        let iata = apiFlight.flight.iata ?? "—"
        let icao = apiFlight.flight.icao ?? "—"
        let number = apiFlight.flight.number
            ?? [apiFlight.flight.iata, apiFlight.flight.icao].compactMap { $0 }.first
            ?? "—"
        
        let duration = apiFlight.estimatedFlightTime ?? "—"
        
        let country = apiFlight.arrival.country ?? apiFlight.departure.country ?? apiFlight.airline.country ?? "—"
        
        let altitude = Flight.formatAltitude(apiFlight.live?.altitude)
        let speed = Flight.formatSpeed(apiFlight.live?.speedHorizontal)
        
        let coordinate = CLLocationCoordinate2D(
            latitude: apiFlight.live?.latitude ?? Flight.defaultCoordinate.latitude,
            longitude: apiFlight.live?.longitude ?? Flight.defaultCoordinate.longitude
        )
        
        self.init(
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            number: number,
            origin: origin,
            destination: destination,
            airline: airlineName,
            duration: duration,
            gateOrigin: gateOrigin,
            gateDestination: gateDestination,
            iata: iata,
            icao: icao,
            aircraftModel: aircraftModel,
            registration: registration,
            country: country,
            altitude: altitude,
            speed: speed,
            coordinate: coordinate,
            media: media
        )
    }
}

private extension Flight {
    static let defaultCoordinate = CLLocationCoordinate2D(latitude: 27.938, longitude: -15.387)
    
    static func formattedCode(iata: String?, icao: String?) -> String? {
        if let iata, !iata.isEmpty {
            return "(\(iata))"
        }
        if let icao, !icao.isEmpty {
            return "(\(icao))"
        }
        return nil
    }
    
    static func formatTime(_ isoDateString: String?) -> String {
        guard let string = isoDateString else { return "—" }
        
        if let date = isoFormatterWithFractional.date(from: string) {
            return timeFormatter.string(from: date)
        }
        
        if let date = isoFormatterBasic.date(from: string) {
            return timeFormatter.string(from: date)
        }
        
        return "—"
    }
    
    static func formatAltitude(_ altitude: Double?) -> String {
        guard let altitude else { return "—" }
        let feet = altitude * 3.28084
        return String(format: "%.0f ft", feet)
    }
    
    static func formatSpeed(_ speed: Double?) -> String {
        guard let speed else { return "—" }
        let knots = speed * 0.539957
        return String(format: "%.0f kt", knots)
    }
    
    static var isoFormatterWithFractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    static var isoFormatterBasic: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter
    }()
}
