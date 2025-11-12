//
//  SampleData.swift
//  GCRadar
//
//  Created by ChatGPT on 12/11/25.
//

import Foundation
import CoreLocation

enum SampleData {
    static let departures: [Flight] = mockFlights
        .filter { $0.departure.isGranCanaria }
        .map { Flight(apiFlight: $0, media: media(for: $0)) }
        .sorted { $0.departureTime < $1.departureTime }
    
    static let arrivals: [Flight] = mockFlights
        .filter { $0.arrival.isGranCanaria }
        .map { Flight(apiFlight: $0, media: media(for: $0)) }
        .sorted { $0.arrivalTime < $1.arrivalTime }
    
    static let overflights: [Flight] = mockFlights
        .filter { $0.isOverflight }
        .map { Flight(apiFlight: $0, media: media(for: $0)) }
    
    /// Backwards compatibility while el resto de pestañas se implementan.
    static let flights: [Flight] = departures
}

// MARK: - Private helpers

private extension SampleData {
    static func media(for flight: AviationStackFlight) -> [AircraftMedia] {
        let key = flight.flight.iata ?? flight.flight.number ?? flight.flight.icao ?? "default"
        return mediaLibrary[key] ?? defaultMedia
    }
    
    static let defaultMedia: [AircraftMedia] = [
        AircraftMedia(
            url: URL(string: "https://images.pexels.com/photos/46148/aircraft-spitfire-propeller-raf-46148.jpeg")!,
            caption: "Cabina en ruta"
        ),
        AircraftMedia(
            url: URL(string: "https://images.pexels.com/photos/358220/pexels-photo-358220.jpeg")!,
            caption: "Trayectoria sobre el Atlántico"
        )
    ]
    
    static let mediaLibrary: [String: [AircraftMedia]] = [
        "NT9018": [
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/358319/pexels-photo-358319.jpeg")!,
                caption: "ATR 72-600 — Binter Canarias"
            ),
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/1309644/pexels-photo-1309644.jpeg")!,
                caption: "Rodaje previo al despegue"
            )
        ],
        "IB3841": [
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/1838681/pexels-photo-1838681.jpeg")!,
                caption: "A321neo en aproximación"
            ),
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/99712/pexels-photo-99712.jpeg")!,
                caption: "Interior de cabina Iberia"
            )
        ],
        "VY1051": [
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/112826/pexels-photo-112826.jpeg")!,
                caption: "Vueling A320 listo para embarque"
            ),
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/358220/pexels-photo-358220.jpeg")!,
                caption: "Ascendiendo desde el archipiélago"
            )
        ],
        "TP1123": [
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/189349/pexels-photo-189349.jpeg")!,
                caption: "Embraer 195 TAP Express"
            ),
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/157171/pexels-photo-157171.jpeg")!,
                caption: "Embarque en Lisboa"
            )
        ],
        "NT8620": [
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/358319/pexels-photo-358319.jpeg")!,
                caption: "Cruce de nubes rumbo al Atlántico"
            ),
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/1449767/pexels-photo-1449767.jpeg")!,
                caption: "E190 de Binter en ruta"
            )
        ],
        "3B2105": [
            AircraftMedia(
                url: URL(string: "https://images.pexels.com/photos/358220/pexels-photo-358220.jpeg")!,
                caption: "Cruce al oeste de Gran Canaria"
            )
        ]
    ]
    
    static let mockFlights: [AviationStackFlight] = [
        AviationStackFlight(
            flightDate: "2025-11-12",
            flightStatus: "scheduled",
            departure: .init(
                airport: "Gran Canaria",
                timezone: "Atlantic/Canary",
                iata: "LPA",
                icao: "GCLP",
                terminal: "B",
                gate: "B12",
                baggage: "05",
                delay: 0,
                scheduled: "2025-11-12T06:10:00+00:00",
                estimated: "2025-11-12T06:10:00+00:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "España"
            ),
            arrival: .init(
                airport: "Adolfo Suárez Madrid-Barajas",
                timezone: "Europe/Madrid",
                iata: "MAD",
                icao: "LEMD",
                terminal: "T2",
                gate: "H23",
                baggage: "05",
                delay: 0,
                scheduled: "2025-11-12T09:00:00+01:00",
                estimated: "2025-11-12T09:00:00+01:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "España"
            ),
            airline: .init(
                name: "Binter Canarias",
                iata: "NT",
                icao: "IBB",
                country: "España"
            ),
            flight: .init(
                number: "9018",
                iata: "NT9018",
                icao: "IBB9018",
                codeshared: nil
            ),
            aircraft: .init(
                registration: "EC-MRE",
                iata: "AT7",
                icao: "AT76",
                icao24: "342433"
            ),
            live: .init(
                updated: "2025-11-12T06:05:00+00:00",
                latitude: 27.939,
                longitude: -15.387,
                altitude: 2800.0,
                direction: 26.0,
                speedHorizontal: 520.0,
                speedVertical: 2.0,
                isGround: false
            ),
            estimatedFlightTime: "2h 50m"
        ),
        AviationStackFlight(
            flightDate: "2025-11-12",
            flightStatus: "scheduled",
            departure: .init(
                airport: "Gran Canaria",
                timezone: "Atlantic/Canary",
                iata: "LPA",
                icao: "GCLP",
                terminal: "C",
                gate: "C06",
                baggage: nil,
                delay: 5,
                scheduled: "2025-11-12T07:25:00+00:00",
                estimated: "2025-11-12T07:30:00+00:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "España"
            ),
            arrival: .init(
                airport: "Barcelona - El Prat",
                timezone: "Europe/Madrid",
                iata: "BCN",
                icao: "LEBL",
                terminal: "1",
                gate: "D18",
                baggage: "12",
                delay: 0,
                scheduled: "2025-11-12T11:05:00+01:00",
                estimated: "2025-11-12T11:10:00+01:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "España"
            ),
            airline: .init(
                name: "Iberia",
                iata: "IB",
                icao: "IBE",
                country: "España"
            ),
            flight: .init(
                number: "3841",
                iata: "IB3841",
                icao: "IBE3841",
                codeshared: nil
            ),
            aircraft: .init(
                registration: "EC-NER",
                iata: "32N",
                icao: "A21N",
                icao24: "342A12"
            ),
            live: .init(
                updated: "2025-11-12T07:20:00+00:00",
                latitude: 27.936,
                longitude: -15.39,
                altitude: 0.0,
                direction: 46.0,
                speedHorizontal: 0.0,
                speedVertical: 0.0,
                isGround: true
            ),
            estimatedFlightTime: "3h 40m"
        ),
        AviationStackFlight(
            flightDate: "2025-11-12",
            flightStatus: "active",
            departure: .init(
                airport: "Lisboa",
                timezone: "Europe/Lisbon",
                iata: "LIS",
                icao: "LPPT",
                terminal: "1",
                gate: "114",
                baggage: nil,
                delay: 0,
                scheduled: "2025-11-12T08:30:00+00:00",
                estimated: "2025-11-12T08:30:00+00:00",
                actual: "2025-11-12T08:33:00+00:00",
                estimatedRunway: "2025-11-12T08:40:00+00:00",
                actualRunway: "2025-11-12T08:41:00+00:00",
                country: "Portugal"
            ),
            arrival: .init(
                airport: "Gran Canaria",
                timezone: "Atlantic/Canary",
                iata: "LPA",
                icao: "GCLP",
                terminal: "A",
                gate: "A09",
                baggage: "06",
                delay: 0,
                scheduled: "2025-11-12T10:45:00+00:00",
                estimated: "2025-11-12T10:42:00+00:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "España"
            ),
            airline: .init(
                name: "TAP Express",
                iata: "TP",
                icao: "TAP",
                country: "Portugal"
            ),
            flight: .init(
                number: "1123",
                iata: "TP1123",
                icao: "TAP1123",
                codeshared: nil
            ),
            aircraft: .init(
                registration: "CS-TTC",
                iata: "E95",
                icao: "E190",
                icao24: "4952C2"
            ),
            live: .init(
                updated: "2025-11-12T09:40:00+00:00",
                latitude: 28.03,
                longitude: -15.85,
                altitude: 32000.0,
                direction: 142.0,
                speedHorizontal: 780.0,
                speedVertical: -3.0,
                isGround: false
            ),
            estimatedFlightTime: "2h 15m"
        ),
        AviationStackFlight(
            flightDate: "2025-11-12",
            flightStatus: "landed",
            departure: .init(
                airport: "Madrid (MAD)",
                timezone: "Europe/Madrid",
                iata: "MAD",
                icao: "LEMD",
                terminal: "T4",
                gate: "K23",
                baggage: "12",
                delay: 0,
                scheduled: "2025-11-12T05:55:00+01:00",
                estimated: "2025-11-12T05:55:00+01:00",
                actual: "2025-11-12T05:57:00+01:00",
                estimatedRunway: "2025-11-12T06:05:00+01:00",
                actualRunway: "2025-11-12T06:07:00+01:00",
                country: "España"
            ),
            arrival: .init(
                airport: "Gran Canaria",
                timezone: "Atlantic/Canary",
                iata: "LPA",
                icao: "GCLP",
                terminal: "A",
                gate: "A04",
                baggage: "03",
                delay: 0,
                scheduled: "2025-11-12T08:10:00+00:00",
                estimated: "2025-11-12T08:05:00+00:00",
                actual: "2025-11-12T08:04:00+00:00",
                estimatedRunway: "2025-11-12T07:55:00+00:00",
                actualRunway: "2025-11-12T07:56:00+00:00",
                country: "España"
            ),
            airline: .init(
                name: "Vueling",
                iata: "VY",
                icao: "VLG",
                country: "España"
            ),
            flight: .init(
                number: "1051",
                iata: "VY1051",
                icao: "VLG1051",
                codeshared: nil
            ),
            aircraft: .init(
                registration: "EC-MAJ",
                iata: "32A",
                icao: "A320",
                icao24: "3421AA"
            ),
            live: .init(
                updated: "2025-11-12T08:03:00+00:00",
                latitude: 27.935,
                longitude: -15.39,
                altitude: 1200.0,
                direction: 18.0,
                speedHorizontal: 220.0,
                speedVertical: -1.5,
                isGround: false
            ),
            estimatedFlightTime: "2h 15m"
        ),
        AviationStackFlight(
            flightDate: "2025-11-12",
            flightStatus: "active",
            departure: .init(
                airport: "Tenerife Sur",
                timezone: "Atlantic/Canary",
                iata: "TFS",
                icao: "GCTS",
                terminal: "1",
                gate: "A02",
                baggage: nil,
                delay: 0,
                scheduled: "2025-11-12T07:40:00+00:00",
                estimated: "2025-11-12T07:38:00+00:00",
                actual: "2025-11-12T07:43:00+00:00",
                estimatedRunway: "2025-11-12T07:47:00+00:00",
                actualRunway: "2025-11-12T07:48:00+00:00",
                country: "España"
            ),
            arrival: .init(
                airport: "Dakar-Léopold Sédar Senghor",
                timezone: "Africa/Dakar",
                iata: "DKR",
                icao: "GOOY",
                terminal: nil,
                gate: nil,
                baggage: nil,
                delay: 0,
                scheduled: "2025-11-12T10:35:00+00:00",
                estimated: "2025-11-12T10:31:00+00:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "Senegal"
            ),
            airline: .init(
                name: "Binter Canarias",
                iata: "NT",
                icao: "IBB",
                country: "España"
            ),
            flight: .init(
                number: "8620",
                iata: "NT8620",
                icao: "IBB8620",
                codeshared: nil
            ),
            aircraft: .init(
                registration: "EC-MVG",
                iata: "E90",
                icao: "E190",
                icao24: "3426C1"
            ),
            live: .init(
                updated: "2025-11-12T08:50:00+00:00",
                latitude: 27.96,
                longitude: -15.2,
                altitude: 29000.0,
                direction: 186.0,
                speedHorizontal: 760.0,
                speedVertical: 0.0,
                isGround: false
            ),
            estimatedFlightTime: "3h 00m"
        ),
        AviationStackFlight(
            flightDate: "2025-11-12",
            flightStatus: "active",
            departure: .init(
                airport: "Lisboa",
                timezone: "Europe/Lisbon",
                iata: "LIS",
                icao: "LPPT",
                terminal: "1",
                gate: "118",
                baggage: nil,
                delay: 0,
                scheduled: "2025-11-12T06:30:00+00:00",
                estimated: "2025-11-12T06:30:00+00:00",
                actual: "2025-11-12T06:32:00+00:00",
                estimatedRunway: "2025-11-12T06:40:00+00:00",
                actualRunway: "2025-11-12T06:41:00+00:00",
                country: "Portugal"
            ),
            arrival: .init(
                airport: "Praia International",
                timezone: "Atlantic/Cape_Verde",
                iata: "RAI",
                icao: "GVNP",
                terminal: nil,
                gate: nil,
                baggage: nil,
                delay: 0,
                scheduled: "2025-11-12T08:40:00-01:00",
                estimated: "2025-11-12T08:38:00-01:00",
                actual: nil,
                estimatedRunway: nil,
                actualRunway: nil,
                country: "Cabo Verde"
            ),
            airline: .init(
                name: "BestFly Cabo Verde",
                iata: "3B",
                icao: "BCV",
                country: "Cabo Verde"
            ),
            flight: .init(
                number: "2105",
                iata: "3B2105",
                icao: "BCV2105",
                codeshared: nil
            ),
            aircraft: .init(
                registration: "D4-CBX",
                iata: "ATR",
                icao: "AT75",
                icao24: "0C207E"
            ),
            live: .init(
                updated: "2025-11-12T07:35:00+00:00",
                latitude: 27.97,
                longitude: -15.45,
                altitude: 18000.0,
                direction: 208.0,
                speedHorizontal: 540.0,
                speedVertical: -0.5,
                isGround: false
            ),
            estimatedFlightTime: "3h 15m"
        )
    ]
}

