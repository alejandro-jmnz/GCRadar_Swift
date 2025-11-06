//
//  FlightRowView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct FlightRowView: View {
    let flight: Flight
    
    var body: some View {
        HStack {
            VStack {
                Text(flight.departure_time)
                Text(flight.number)
                Text(flight.destination)
            }
            Spacer()
            Text(flight.airline)
        }
    }
}

