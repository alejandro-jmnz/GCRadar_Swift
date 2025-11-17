//
//  isWithinGCRange.swift
//  GCRadar
//
//  Created by alumno on 17/11/25.
//

import Foundation

// Nos devuelve si sobrevuela el espacio aerio de Gran Canaria
extension Flight {
    var isWithinGCRange: Bool {
        let minLat = 26.82
        let maxLat = 28.77
        let minLon = -16.01
        let maxLon = -14.58

        return live.latitude >= minLat && live.latitude <= maxLat &&
               live.longitude >= minLon && live.longitude <= maxLon
    }
}
