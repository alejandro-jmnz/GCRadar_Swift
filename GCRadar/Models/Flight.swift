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
        let icao: String
    }
    
    struct LiveInfo {
        let latitude: Double
        let longitude: Double
        let altitude: Double
        let speed: Double
    }
    
    struct AircraftInfo {
        let model: String
        let registration: String
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
