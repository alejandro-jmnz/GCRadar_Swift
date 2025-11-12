//
//  Flight.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import Foundation

struct Flight: Identifiable {
    let id = UUID()
    let departure_time: String
    let arrival_time: String
    let number: String
    let origin: String
    let destination: String
    let airline: String
}
