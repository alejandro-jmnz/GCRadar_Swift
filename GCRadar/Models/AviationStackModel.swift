//
//  AviationStackModel.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

// MODELO DE LA RESPUESTA QUE SE OBTIENE DE LA API


import Foundation

// Cambiamos Decodable por Codable para que la caché (JSONEncoder) pueda guardar estos datos
struct AviationStackResponse: Codable {
    let data: [ApiFlightData]
}

struct ApiFlightData: Codable {
    let flight_date: String?
    let flight_status: String?
    let departure: ApiEndpoint?
    let arrival: ApiEndpoint?
    let airline: ApiAirline?
    let flight: ApiFlightDetails?
    let aircraft: ApiAircraft?
    let live: ApiLive?
}

struct ApiEndpoint: Codable {
    let airport: String?
    let timezone: String?
    let iata: String?
    let icao: String?
    let terminal: String?
    let gate: String?
    let delay: Int?
    let scheduled: String?
    let estimated: String?
}

struct ApiAirline: Codable {
    let name: String?
    let iata: String?
    let icao: String?
}

struct ApiFlightDetails: Codable {
    let number: String?
    let iata: String?
    let icao: String?
}

struct ApiAircraft: Codable {
    let registration: String?
    let iata: String? // Este es el modelo del avión
    let icao: String?
    let icao24: String?
}

struct ApiLive: Codable {
    let updated: String?
    let latitude: Double?
    let longitude: Double?
    let altitude: Double?
    let direction: Double?
    let speed_horizontal: Double? // <--- Correcto, coincide con el JSON
    let speed_vertical: Double?
    let is_ground: Bool?
}

/*
import Foundation

// Estructura raíz de la respuesta de la API
struct AviationStackResponse: Decodable {
    let data: [ApiFlightData]
}

// Representa un vuelo tal cual viene de la API
struct ApiFlightData: Decodable {
    let flight_date: String?
    let flight_status: String?
    let departure: ApiEndpoint?
    let arrival: ApiEndpoint?
    let airline: ApiAirline?
    let flight: ApiFlightDetails?
    let aircraft: ApiAircraft?
    let live: ApiLive?
}

struct ApiEndpoint: Decodable {
    let airport: String?
    let timezone: String?
    let iata: String?
    let icao: String?
    let terminal: String?
    let gate: String?
    let delay: Int?
    let scheduled: String? // La API devuelve la fecha aquí
    let estimated: String?
}

struct ApiAirline: Decodable {
    let name: String?
    let iata: String?
    let icao: String?
}

struct ApiFlightDetails: Decodable {
    let number: String?
    let iata: String?
    let icao: String?
}

struct ApiAircraft: Decodable {
    let registration: String?
    let iata: String?
    let icao: String?
    let icao24: String?
}

struct ApiLive: Decodable {
    let updated: String?
    let latitude: Double?
    let longitude: Double?
    let altitude: Double?
    let direction: Double?
    let speed_horizontal: Double?
    let speed_vertical: Double?
    let is_ground: Bool?
}
*/
