//
//  AviationStackModels.swift
//  GCRadar
//
//  Created by ChatGPT on 12/11/25.
//

import Foundation

struct AviationStackFlight: Identifiable {
    struct AirportInfo {
        let airport: String?
        let timezone: String?
        let iata: String?
        let icao: String?
        let terminal: String?
        let gate: String?
        let baggage: String?
        let delay: Int?
        let scheduled: String?
        let estimated: String?
        let actual: String?
        let estimatedRunway: String?
        let actualRunway: String?
        let country: String?
    }
    
    struct AirlineInfo {
        let name: String?
        let iata: String?
        let icao: String?
        let country: String?
    }
    
    struct FlightInfo {
        let number: String?
        let iata: String?
        let icao: String?
        let codeshared: String?
    }
    
    struct AircraftInfo {
        let registration: String?
        let iata: String?
        let icao: String?
        let icao24: String?
    }
    
    struct LiveInfo {
        let updated: String?
        let latitude: Double?
        let longitude: Double?
        let altitude: Double?
        let direction: Double?
        let speedHorizontal: Double?
        let speedVertical: Double?
        let isGround: Bool?
    }
    
    let id = UUID()
    let flightDate: String?
    let flightStatus: String?
    let departure: AirportInfo
    let arrival: AirportInfo
    let airline: AirlineInfo
    let flight: FlightInfo
    let aircraft: AircraftInfo
    let live: LiveInfo?
    /// Custom helper to emulate additional data that might be computed from the API.
    let estimatedFlightTime: String?
}

extension AviationStackFlight.AirportInfo {
    private static let granCanariaIataCode = "LPA"
    
    var isGranCanaria: Bool {
        (iata?.uppercased() ?? "") == Self.granCanariaIataCode
            || airport?.lowercased().contains("grancanaria") == true
            || airport?.lowercased().contains("gran canaria") == true
    }
}

extension AviationStackFlight {
    var preferredFlightIdentifier: String {
        flight.iata ?? flight.number ?? flight.icao ?? UUID().uuidString
    }
    
    var isOverflight: Bool {
        !departure.isGranCanaria && !arrival.isGranCanaria
    }
}

