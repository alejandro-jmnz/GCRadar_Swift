//
//  DeparturesView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct DeparturesView: View {
    // Datos que emulan la respuesta de AviationStack mientras no haya API
    private let flights: [Flight] = SampleData.departures
    
    var body: some View {
        ZStack {
            Color(hex: "#121212").ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HeaderView()
                    FlightTableView(flights: flights)
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
                .padding(.bottom, 120)
            }
        }
    }
}

// MARK: - Header

private struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [Color(hex: "#3FA7D6"), Color(hex: "#0C1A2B")]),
                                center: .center,
                                startRadius: 0,
                                endRadius: 60
                            )
                        )
                        .frame(width: 64, height: 64)
                    Image(systemName: "location.north.line.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("GCRadar")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Gran Canaria Airport · LPA")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Salidas")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                Text("Sigue los vuelos que despegan desde Gran Canaria en tiempo real.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
    }
}

// MARK: - Flight Table

private struct FlightTableView: View {
    let flights: [Flight]
    
    var body: some View {
        VStack(spacing: 16) {
            FlightTableHeader()
            
            VStack(spacing: 12) {
                ForEach(flights) { flight in
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        FlightRowView(flight: flight)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }
}

private struct FlightTableHeader: View {
    var body: some View {
        HStack {
            Text("Hora")
                .flightHeaderStyle()
                .frame(width: 60, alignment: .leading)
            Text("Nº vuelo")
                .flightHeaderStyle()
                .frame(minWidth: 80, alignment: .leading)
            Text("Destino")
                .flightHeaderStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Aerolínea")
                .flightHeaderStyle()
                .frame(width: 90, alignment: .trailing)
        }
        .padding(.horizontal, 16)
    }
}

private extension Text {
    func flightHeaderStyle() -> some View {
        font(.footnote.weight(.semibold))
            .foregroundStyle(Color.white.opacity(0.7))
            .textCase(.uppercase)
    }
}

#Preview {
    NavigationStack {
        DeparturesView()
    }
}
