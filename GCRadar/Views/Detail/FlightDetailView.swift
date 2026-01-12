//
//  FlightDetailView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct FlightDetailView: View {
    let flight: Flight
    @State private var isFavorite = false
    @State private var showImages = false

    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // --- CABECERA: RUTA Y TIEMPOS ---
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(flight.origin.iata)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                            Text(flight.origin.airport)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                            Text(flight.timeOnly(from: flight.departureTime))
                                .font(.title3)
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "airplane")
                                .font(.title)
                                .foregroundColor(.blue)
                            Text(flight.durationString)
                                .font(.caption2)
                                .padding(4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(flight.destination.iata)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                            Text(flight.destination.airport)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                            Text(flight.timeOnly(from: flight.arrivalTime))
                                .font(.title3)
                                .bold()
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(15)

                // --- INFORMACIÓN DE PUERTAS Y TERMINALES ---
                HStack(spacing: 15) {
                    InfoTile(label: "Origen",
                             terminal: flight.origin.terminal,
                             gate: flight.origin.gate)
                    InfoTile(label: "Destino",
                             terminal: flight.destination.terminal,
                             gate: flight.destination.gate)
                }

                // --- DETALLES DEL VUELO Y AERONAVE ---
                VStack(spacing: 1) {
                    DetailRow(title: "Número de Vuelo", value: flight.identifiers.iata, icon: "number")
                    DetailRow(title: "Aerolínea", value: flight.airline.name, icon: "building.columns")
                    DetailRow(title: "Aeronave", value: flight.aircraft.model, icon: "airplane.circle")
                    DetailRow(title: "Matrícula", value: flight.aircraft.registration, icon: "tag")
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(15)

                // --- ESTADO EN VIVO (Telemetría) ---
                VStack {
                    HStack {
                        Text("Estado en tiempo real")
                            .font(.headline)
                        Spacer()
                        if flight.isLive {
                            Text("EN VIVO")
                                .font(.caption2).bold()
                                .padding(4)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                    }
                    
                    if flight.isLive {
                        HStack {
                            LiveStat(label: "Altitud", value: "\(String(format: "%.0f", flight.live.altitude)) m", icon: "arrow.up.and.down")
                            Spacer()
                            LiveStat(label: "Velocidad", value: "\(String(format: "%.0f", flight.live.speed)) km/h", icon: "speedometer")
                        }
                    } else {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("Los datos de telemetría estarán disponibles cuando el avión esté en vuelo.")
                                .font(.footnote)
                        }
                        .foregroundColor(.gray)
                        .padding(.vertical, 5)
                    }
                }
                .padding()
                .background(flight.isLive ? Color.blue.opacity(0.05) : Color.gray.opacity(0.05))
                .cornerRadius(15)
                
                // Botón para fotos (Placeholder para el carrusel)
                Button{
                    showImages = true
                } label: {
                    Label("Ver fotos de la aeronave", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .sheet(isPresented: $showImages) {
                    ImageCarouselView(query: flight.aircraft.model)
                }
            }
            .padding()
        }
        .navigationTitle(flight.identifiers.iata)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
        }
    }
}

// MARK: - Componentes de apoyo (Subvistas)

struct InfoTile: View {
    let label: String
    let terminal: String?
    let gate: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label).font(.caption).foregroundColor(.gray)
            Text("Terminal \(terminal ?? "N/A")").bold()
            Text("Puerta \(gate ?? "N/A")").bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundColor(.blue).frame(width: 25)
            Text(title).foregroundColor(.gray)
            Spacer()
            Text(value).bold()
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct LiveStat: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(label).font(.caption2).foregroundColor(.gray)
                Text(value).font(.headline)
            }
        }
    }
}
/*
struct FlightDetailView: View {
    let flight: Flight
    @State private var showMap = false // Controla si muestra el mapa o no
    // TODO mapa
    @State private var isFavorite = false // Controla si es favorito o no
    // TODO favoritos
    
    
    var body: some View {
        ScrollView {
            VStack {
                // 1er recuadro
                HStack {
                    VStack {
                        Image(systemName: "airplane.departure")
                        Text(flight.origin.airport)
                        Text(flight.departureTime)
                    }
                    .padding()
                    VStack {
                        Image(systemName: "airplane")
                        Text(flight.durationString)
                    }
                    .padding()
                    VStack {
                        Image(systemName: "airplane.arrival")
                        Text(flight.destination.airport)
                        Text(flight.arrivalTime)
                    }
                    .padding()
                    
                    Button(action: { // Boton de favoritos
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                    }
                }
                .padding()
                
                // 2o recuadro
                HStack {
                    VStack {
                        Text("Terminal \(flight.origin.terminal ?? "")") // Si es nulo se imprime una cadena vacia
                        Text(" Puerta \(flight.origin.gate ?? "")")
                    }
                    Spacer()
                    VStack {
                        Text("Terminal \(flight.destination.terminal ?? "")")
                        Text(" Puerta \(flight.destination.gate ?? "")")
                    }
                    
                }
                .padding()
                
                // 3er recuadro
                HStack {
                    VStack {
                        Text(flight.identifiers.iata)
                        Text("Numero de vuelo")
                    }
                    Spacer()
                    VStack {
                        Text(flight.aircraft.registration)
                        Text("Matrícula")
                    }
                    CompanyLogo(name: domain(for: flight.airline.name))
                }
                .padding()
                
                // 4o recuadro
                HStack {
                    VStack {
                        Text(flight.aircraft.model)
                        Text("Modelo de aeronave")
                    }
                    Spacer()
                    VStack {
                        Text("\(flight.airline.name) (\(flight.airline.iata))")
                        Text("Aerolinea")
                    }
                }
                .padding()
                
                // 5o recuadro
                HStack {
                    VStack {
                        Text(String(format: "%.0f", flight.live.altitude)) // Formato sin decimales
                        Text("Altura (m)")
                    }
                    Spacer()
                    VStack {
                        Text(String(format: "%.0f", flight.live.speed))
                        Text("Velocidad (km/h)")
                    }
                }
                .padding()
                
                
                
                // Selector simple de dos botones
                HStack(spacing: 12) { // TODO hacerlo como en el diseno
                    Button(action: { showMap = false}) {
                        Text("Aeronave") // TODO anadir vista de carrousel con fotos de la aeronave
                    }
                    
                    Button(action: { showMap = true}) {
                        Text("Mapa") // TODO anadir vista del mapa con la aeronave en tiempo real
                    }
                }
                
                // Comentamos el carrousel para no gastar busquedas en la API
                // ImageCarouselView(query: flight.aircraft.model)
            }
                
        }
    }
}
*/
