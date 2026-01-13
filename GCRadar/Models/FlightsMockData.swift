//
//  FlightsMockData.swift
//  GCRadar
//
//  Created by alumno on 23/11/25.
//


// Vuelos de ejemplo

import Foundation

struct FlightsMockData {
    static let flights: [Flight] = [
        // 1 — LPA → Tenerife Sur
        Flight(
            departureTime: "2024-01-15T06:20:00+00:00",
            arrivalTime: "2024-01-15T06:55:00+00:00",
            departureDelay: 1,
            arrivalDelay: 0,
            identifiers: .init(iata: "NT221", icao: "IBB221"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A05", terminal: "A"),
            destination: .init(airport: "Tenerife Sur (TFS)", iata: "TFS", gate: "B11", terminal: "1"),
            live: .init(latitude: 27.90, longitude: -15.30, altitude: 1800.0, speed: 310.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-600", registration: "EC-NEZ"),
            isLive: true
        ),

        // 2 — Tenerife Norte → LPA
        Flight(
            departureTime: "2024-01-15T06:45:00+00:00",
            arrivalTime: "2024-01-15T07:25:00+00:00",
            departureDelay: 0,
            arrivalDelay: 2,
            identifiers: .init(iata: "NT111", icao: "IBB111"),
            origin: .init(airport: "Tenerife Norte (TFN)", iata: "TFN", gate: "A14", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C09", terminal: "C"),
            live: .init(latitude: 28.10, longitude: -15.60, altitude: 2400.0, speed: 330.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-500", registration: "EC-LQZ"),
            isLive: true
        ),

        // 3 — LPA → Sevilla
        Flight(
            departureTime: "2024-01-15T07:10:00+00:00",
            arrivalTime: "2024-01-15T10:55:00+00:00",
            departureDelay: 0,
            arrivalDelay: 4,
            identifiers: .init(iata: "VY3182", icao: "VLG3182"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B04", terminal: "B"),
            destination: .init(airport: "Sevilla (SVQ)", iata: "SVQ", gate: "14", terminal: "1"),
            live: .init(latitude: 28.50, longitude: -14.90, altitude: 10700.0, speed: 810.0),
            airline: .init(name: "Vueling", iata: "VY"),
            aircraft: .init(model: "Airbus A320", registration: "EC-MBH"),
            isLive: true
        ),

        // 4 — LPA → Amsterdam
        Flight(
            departureTime: "2024-01-15T07:55:00+00:00",
            arrivalTime: "2024-01-15T13:25:00+00:00",
            departureDelay: 3,
            arrivalDelay: 0,
            identifiers: .init(iata: "HV5666", icao: "TRA5666"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "D05", terminal: "D"),
            destination: .init(airport: "Amsterdam (AMS)", iata: "AMS", gate: "F20", terminal: "1"),
            live: .init(latitude: 28.30, longitude: -14.75, altitude: 11300.0, speed: 835.0),
            airline: .init(name: "Transavia", iata: "HV"),
            aircraft: .init(model: "Boeing 737-800", registration: "PH-HXC"),
            isLive: true
        ),

        // 5 — LPA → Fuerteventura
        Flight(
            departureTime: "2024-01-15T08:10:00+00:00",
            arrivalTime: "2024-01-15T08:45:00+00:00",
            departureDelay: 0,
            arrivalDelay: 1,
            identifiers: .init(iata: "NT512", icao: "IBB512"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C16", terminal: "C"),
            destination: .init(airport: "Fuerteventura (FUE)", iata: "FUE", gate: "2", terminal: "1"),
            live: .init(latitude: 27.70, longitude: -15.20, altitude: 1900.0, speed: 315.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-600", registration: "EC-MQN"),
            isLive: true
        ),

        // 6 — Frankfurt → LPA
        Flight(
            departureTime: "2024-01-15T06:20:00+00:00",
            arrivalTime: "2024-01-15T10:35:00+00:00",
            departureDelay: 5,
            arrivalDelay: 0,
            identifiers: .init(iata: "LH1504", icao: "DLH1504"),
            origin: .init(airport: "Frankfurt (FRA)", iata: "FRA", gate: "A52", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C22", terminal: "C"),
            live: .init(latitude: 34.80, longitude: -10.90, altitude: 11700.0, speed: 860.0),
            airline: .init(name: "Lufthansa", iata: "LH"),
            aircraft: .init(model: "Airbus A321neo", registration: "D-AIEN"),
            isLive: true
        ),

        // 7 — London Gatwick → LPA
        Flight(
            departureTime: "2024-01-15T08:45:00+00:00",
            arrivalTime: "2024-01-15T12:55:00+00:00",
            departureDelay: 0,
            arrivalDelay: 2,
            identifiers: .init(iata: "BA2730", icao: "BAW2730"),
            origin: .init(airport: "London Gatwick (LGW)", iata: "LGW", gate: "N11", terminal: "N"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A10", terminal: "A"),
            live: .init(latitude: 30.50, longitude: -12.50, altitude: 11200.0, speed: 840.0),
            airline: .init(name: "British Airways", iata: "BA"),
            aircraft: .init(model: "Airbus A320neo", registration: "G-TTOE"),
            isLive: true
        ),

        // 8 — Barcelona → LPA
        Flight(
            departureTime: "2024-01-15T09:20:00+00:00",
            arrivalTime: "2024-01-15T12:05:00+00:00",
            departureDelay: 0,
            arrivalDelay: 3,
            identifiers: .init(iata: "VY3065", icao: "VLG3065"),
            origin: .init(airport: "Barcelona (BCN)", iata: "BCN", gate: "A22", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "D07", terminal: "D"),
            live: .init(latitude: 29.40, longitude: -13.40, altitude: 10900.0, speed: 805.0),
            airline: .init(name: "Vueling", iata: "VY"),
            aircraft: .init(model: "Airbus A321", registration: "EC-MHH"),
            isLive: true
        ),

        // 9 — LPA → Valencia
        Flight(
            departureTime: "2024-01-15T10:05:00+00:00",
            arrivalTime: "2024-01-15T13:35:00+00:00",
            departureDelay: 2,
            arrivalDelay: 0,
            identifiers: .init(iata: "IB8542", icao: "IBE8542"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B12", terminal: "B"),
            destination: .init(airport: "Valencia (VLC)", iata: "VLC", gate: "C19", terminal: "1"),
            live: .init(latitude: 28.55, longitude: -14.90, altitude: 11400.0, speed: 825.0),
            airline: .init(name: "Iberia", iata: "IB"),
            aircraft: .init(model: "Airbus A320", registration: "EC-LUK"),
            isLive: true
        ),

        // 10 — LPA → Málaga
        Flight(
            departureTime: "2024-01-15T10:40:00+00:00",
            arrivalTime: "2024-01-15T14:05:00+00:00",
            departureDelay: 1,
            arrivalDelay: 6,
            identifiers: .init(iata: "FR2921", icao: "RYR2921"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "D14", terminal: "D"),
            destination: .init(airport: "Málaga (AGP)", iata: "AGP", gate: "C11", terminal: "3"),
            live: .init(latitude: 28.35, longitude: -14.60, altitude: 11050.0, speed: 840.0),
            airline: .init(name: "Ryanair", iata: "FR"),
            aircraft: .init(model: "Boeing 737-800", registration: "EI-DHC"),
            isLive: true
        ),

        // 11 — LPA → París Orly
        Flight(
            departureTime: "2024-01-15T11:25:00+00:00",
            arrivalTime: "2024-01-15T16:00:00+00:00",
            departureDelay: 0,
            arrivalDelay: 3,
            identifiers: .init(iata: "TO7631", icao: "TVF7631"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A14", terminal: "A"),
            destination: .init(airport: "Paris Orly (ORY)", iata: "ORY", gate: "C02", terminal: "3"),
            live: .init(latitude: 28.10, longitude: -14.85, altitude: 11200.0, speed: 860.0),
            airline: .init(name: "Transavia France", iata: "TO"),
            aircraft: .init(model: "Boeing 737-800", registration: "F-GZHF"),
            isLive: true
        ),

        // 12 — Lisboa → LPA
        Flight(
            departureTime: "2024-01-15T12:05:00+00:00",
            arrivalTime: "2024-01-15T14:15:00+00:00",
            departureDelay: 0,
            arrivalDelay: 1,
            identifiers: .init(iata: "TP1120", icao: "TAP1120"),
            origin: .init(airport: "Lisboa (LIS)", iata: "LIS", gate: "16", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B08", terminal: "B"),
            live: .init(latitude: 29.80, longitude: -11.90, altitude: 10500.0, speed: 770.0),
            airline: .init(name: "TAP Air Portugal", iata: "TP"),
            aircraft: .init(model: "Airbus A320neo", registration: "CS-TVB"),
            isLive: true
        ),

        // --------------------------------------------
        // 13–40: Vuelos EN RANGO pero sin LPA
        // --------------------------------------------

        Flight(
            departureTime: "2024-01-15T11:00:00+00:00",
            arrivalTime: "2024-01-15T13:40:00+00:00",
            departureDelay: 1,
            arrivalDelay: 0,
            identifiers: .init(iata: "AF732", icao: "AFR732"),
            origin: .init(airport: "Paris CDG (CDG)", iata: "CDG", gate: "F12", terminal: "2F"),
            destination: .init(airport: "Nouakchott (NKC)", iata: "NKC", gate: "3", terminal: nil),
            live: .init(latitude: 27.90, longitude: -15.50, altitude: 11500.0, speed: 825.0),
            airline: .init(name: "Air France", iata: "AF"),
            aircraft: .init(model: "Airbus A330-200", registration: "F-GZCH"),
            isLive: true
        ),

        Flight(
            departureTime: "2024-01-15T13:15:00+00:00",
            arrivalTime: "2024-01-15T16:00:00+00:00",
            departureDelay: 0,
            arrivalDelay: 0,
            identifiers: .init(iata: "KL713", icao: "KLM713"),
            origin: .init(airport: "Amsterdam (AMS)", iata: "AMS", gate: "E10", terminal: "1"),
            destination: .init(airport: "Paramaribo (PBM)", iata: "PBM", gate: nil, terminal: nil),
            live: .init(latitude: 28.40, longitude: -14.95, altitude: 11250.0, speed: 850.0),
            airline: .init(name: "KLM", iata: "KL"),
            aircraft: .init(model: "Boeing 777-300ER", registration: "PH-BVV"),
            isLive: true
        ),

        Flight(
            departureTime: "2024-01-15T14:25:00+00:00",
            arrivalTime: "2024-01-15T18:10:00+00:00",
            departureDelay: 4,
            arrivalDelay: 7,
            identifiers: .init(iata: "IB6081", icao: "IBE6081"),
            origin: .init(airport: "Madrid (MAD)", iata: "MAD", gate: "S24", terminal: "4S"),
            destination: .init(airport: "São Paulo (GRU)", iata: "GRU", gate: nil, terminal: nil),
            live: .init(latitude: 27.20, longitude: -15.40, altitude: 11800.0, speed: 880.0),
            airline: .init(name: "Iberia", iata: "IB"),
            aircraft: .init(model: "Airbus A350-900", registration: "EC-NBG"),
            isLive: true
        )
    ]
}
