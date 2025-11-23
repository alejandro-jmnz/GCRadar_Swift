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
            departureTime: "06:20",
            arrivalTime: "06:55",
            departureDelay: 1,
            arrivalDelay: 0,
            identifiers: .init(iata: "NT221", icao: "IBB221"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A05", terminal: "A"),
            destination: .init(airport: "Tenerife Sur (TFS)", iata: "TFS", gate: "B11", terminal: "1"),
            live: .init(latitude: 27.90, longitude: -15.30, altitude: 1800.0, speed: 310.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-600", registration: "EC-NEZ")
        ),

        // 2 — Tenerife Norte → LPA
        Flight(
            departureTime: "06:45",
            arrivalTime: "07:25",
            departureDelay: 0,
            arrivalDelay: 2,
            identifiers: .init(iata: "NT111", icao: "IBB111"),
            origin: .init(airport: "Tenerife Norte (TFN)", iata: "TFN", gate: "A14", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C09", terminal: "C"),
            live: .init(latitude: 28.10, longitude: -15.60, altitude: 2400.0, speed: 330.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-500", registration: "EC-LQZ")
        ),

        // 3 — LPA → Sevilla
        Flight(
            departureTime: "07:10",
            arrivalTime: "10:55",
            departureDelay: 0,
            arrivalDelay: 4,
            identifiers: .init(iata: "VY3182", icao: "VLG3182"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B04", terminal: "B"),
            destination: .init(airport: "Sevilla (SVQ)", iata: "SVQ", gate: "14", terminal: "1"),
            live: .init(latitude: 28.50, longitude: -14.90, altitude: 10700.0, speed: 810.0),
            airline: .init(name: "Vueling", iata: "VY"),
            aircraft: .init(model: "Airbus A320", registration: "EC-MBH")
        ),

        // 4 — LPA → Amsterdam
        Flight(
            departureTime: "07:55",
            arrivalTime: "13:25",
            departureDelay: 3,
            arrivalDelay: 0,
            identifiers: .init(iata: "HV5666", icao: "TRA5666"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "D05", terminal: "D"),
            destination: .init(airport: "Amsterdam (AMS)", iata: "AMS", gate: "F20", terminal: "1"),
            live: .init(latitude: 28.30, longitude: -14.75, altitude: 11300.0, speed: 835.0),
            airline: .init(name: "Transavia", iata: "HV"),
            aircraft: .init(model: "Boeing 737-800", registration: "PH-HXC")
        ),

        // 5 — LPA → Fuerteventura
        Flight(
            departureTime: "08:10",
            arrivalTime: "08:45",
            departureDelay: 0,
            arrivalDelay: 1,
            identifiers: .init(iata: "NT512", icao: "IBB512"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C16", terminal: "C"),
            destination: .init(airport: "Fuerteventura (FUE)", iata: "FUE", gate: "2", terminal: "1"),
            live: .init(latitude: 27.70, longitude: -15.20, altitude: 1900.0, speed: 315.0),
            airline: .init(name: "Binter Canarias", iata: "NT"),
            aircraft: .init(model: "ATR 72-600", registration: "EC-MQN")
        ),

        // 6 — Frankfurt → LPA
        Flight(
            departureTime: "06:20",
            arrivalTime: "10:35",
            departureDelay: 5,
            arrivalDelay: 0,
            identifiers: .init(iata: "LH1504", icao: "DLH1504"),
            origin: .init(airport: "Frankfurt (FRA)", iata: "FRA", gate: "A52", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "C22", terminal: "C"),
            live: .init(latitude: 34.80, longitude: -10.90, altitude: 11700.0, speed: 860.0),
            airline: .init(name: "Lufthansa", iata: "LH"),
            aircraft: .init(model: "Airbus A321neo", registration: "D-AIEN")
        ),

        // 7 — London Gatwick → LPA
        Flight(
            departureTime: "08:45",
            arrivalTime: "12:55",
            departureDelay: 0,
            arrivalDelay: 2,
            identifiers: .init(iata: "BA2730", icao: "BAW2730"),
            origin: .init(airport: "London Gatwick (LGW)", iata: "LGW", gate: "N11", terminal: "N"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A10", terminal: "A"),
            live: .init(latitude: 30.50, longitude: -12.50, altitude: 11200.0, speed: 840.0),
            airline: .init(name: "British Airways", iata: "BA"),
            aircraft: .init(model: "Airbus A320neo", registration: "G-TTOE")
        ),

        // 8 — Barcelona → LPA
        Flight(
            departureTime: "09:20",
            arrivalTime: "12:05",
            departureDelay: 0,
            arrivalDelay: 3,
            identifiers: .init(iata: "VY3065", icao: "VLG3065"),
            origin: .init(airport: "Barcelona (BCN)", iata: "BCN", gate: "A22", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "D07", terminal: "D"),
            live: .init(latitude: 29.40, longitude: -13.40, altitude: 10900.0, speed: 805.0),
            airline: .init(name: "Vueling", iata: "VY"),
            aircraft: .init(model: "Airbus A321", registration: "EC-MHH")
        ),

        // 9 — LPA → Valencia
        Flight(
            departureTime: "10:05",
            arrivalTime: "13:35",
            departureDelay: 2,
            arrivalDelay: 0,
            identifiers: .init(iata: "IB8542", icao: "IBE8542"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B12", terminal: "B"),
            destination: .init(airport: "Valencia (VLC)", iata: "VLC", gate: "C19", terminal: "1"),
            live: .init(latitude: 28.55, longitude: -14.90, altitude: 11400.0, speed: 825.0),
            airline: .init(name: "Iberia", iata: "IB"),
            aircraft: .init(model: "Airbus A320", registration: "EC-LUK")
        ),

        // 10 — LPA → Málaga
        Flight(
            departureTime: "10:40",
            arrivalTime: "14:05",
            departureDelay: 1,
            arrivalDelay: 6,
            identifiers: .init(iata: "FR2921", icao: "RYR2921"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "D14", terminal: "D"),
            destination: .init(airport: "Málaga (AGP)", iata: "AGP", gate: "C11", terminal: "3"),
            live: .init(latitude: 28.35, longitude: -14.60, altitude: 11050.0, speed: 840.0),
            airline: .init(name: "Ryanair", iata: "FR"),
            aircraft: .init(model: "Boeing 737-800", registration: "EI-DHC")
        ),

        // 11 — LPA → París Orly
        Flight(
            departureTime: "11:25",
            arrivalTime: "16:00",
            departureDelay: 0,
            arrivalDelay: 3,
            identifiers: .init(iata: "TO7631", icao: "TVF7631"),
            origin: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "A14", terminal: "A"),
            destination: .init(airport: "Paris Orly (ORY)", iata: "ORY", gate: "C02", terminal: "3"),
            live: .init(latitude: 28.10, longitude: -14.85, altitude: 11200.0, speed: 860.0),
            airline: .init(name: "Transavia France", iata: "TO"),
            aircraft: .init(model: "Boeing 737-800", registration: "F-GZHF")
        ),

        // 12 — Lisboa → LPA
        Flight(
            departureTime: "12:05",
            arrivalTime: "14:15",
            departureDelay: 0,
            arrivalDelay: 1,
            identifiers: .init(iata: "TP1120", icao: "TAP1120"),
            origin: .init(airport: "Lisboa (LIS)", iata: "LIS", gate: "16", terminal: "1"),
            destination: .init(airport: "Gran Canaria (LPA)", iata: "LPA", gate: "B08", terminal: "B"),
            live: .init(latitude: 29.80, longitude: -11.90, altitude: 10500.0, speed: 770.0),
            airline: .init(name: "TAP Air Portugal", iata: "TP"),
            aircraft: .init(model: "Airbus A320neo", registration: "CS-TVB")
        ),

        // --------------------------------------------
        // 13–40: Vuelos EN RANGO pero sin LPA
        // --------------------------------------------

        Flight(
            departureTime: "11:00",
            arrivalTime: "13:40",
            departureDelay: 1,
            arrivalDelay: 0,
            identifiers: .init(iata: "AF732", icao: "AFR732"),
            origin: .init(airport: "Paris CDG (CDG)", iata: "CDG", gate: "F12", terminal: "2F"),
            destination: .init(airport: "Nouakchott (NKC)", iata: "NKC", gate: "3", terminal: nil),
            live: .init(latitude: 27.90, longitude: -15.50, altitude: 11500.0, speed: 825.0),
            airline: .init(name: "Air France", iata: "AF"),
            aircraft: .init(model: "Airbus A330-200", registration: "F-GZCH")
        ),

        Flight(
            departureTime: "13:15",
            arrivalTime: "16:00",
            departureDelay: 0,
            arrivalDelay: 0,
            identifiers: .init(iata: "KL713", icao: "KLM713"),
            origin: .init(airport: "Amsterdam (AMS)", iata: "AMS", gate: "E10", terminal: "1"),
            destination: .init(airport: "Paramaribo (PBM)", iata: "PBM", gate: nil, terminal: nil),
            live: .init(latitude: 28.40, longitude: -14.95, altitude: 11250.0, speed: 850.0),
            airline: .init(name: "KLM", iata: "KL"),
            aircraft: .init(model: "Boeing 777-300ER", registration: "PH-BVV")
        ),

        Flight(
            departureTime: "14:25",
            arrivalTime: "18:10",
            departureDelay: 4,
            arrivalDelay: 7,
            identifiers: .init(iata: "IB6081", icao: "IBE6081"),
            origin: .init(airport: "Madrid (MAD)", iata: "MAD", gate: "S24", terminal: "4S"),
            destination: .init(airport: "São Paulo (GRU)", iata: "GRU", gate: nil, terminal: nil),
            live: .init(latitude: 27.20, longitude: -15.40, altitude: 11800.0, speed: 880.0),
            airline: .init(name: "Iberia", iata: "IB"),
            aircraft: .init(model: "Airbus A350-900", registration: "EC-NBG")
        )
    ]
}
