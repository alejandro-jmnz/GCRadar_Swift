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
        let destinationParts = flight.destination.components(separatedBy: "(")
        let city = destinationParts.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? flight.destination
        let code = destinationParts.count > 1
        ? destinationParts[1].replacingOccurrences(of: ")", with: "")
        : ""
        
        HStack(spacing: 16) {
            Text(flight.departureTime)
                .font(.headline.weight(.medium))
                .foregroundStyle(.white)
                .frame(width: 60, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.number)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                Text(flight.airline)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.6))
                    .lineLimit(1)
            }
            .frame(minWidth: 120, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(city)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(Color(hex: "#00FFD1"))
                if !code.isEmpty {
                    Text(code)
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.white.opacity(0.6))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            CompanyLogo(name: domain(for: flight.airline))
            
            Image(systemName: "star")
                .font(.title3.weight(.semibold))
                .foregroundStyle(Color(hex: "#FFD447"))
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(hex: "#1F1F1F"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

