//
//  FlightDetailView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI
import MapKit

struct FlightDetailView: View {
    enum Segment {
        case aircraft
        case map
    }
    
    let flight: Flight
    @State private var selectedSegment: Segment = .map
    @State private var camera: MapCameraPosition
    
    init(flight: Flight) {
        self.flight = flight
        let region = MKCoordinateRegion(
            center: flight.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        )
        _camera = State(initialValue: .region(region))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                HeaderCard(flight: flight)
                InfoGrid(flight: flight)
                SegmentPicker(selected: $selectedSegment)
                
                switch selectedSegment {
                case .aircraft:
                    AircraftCarousel(mediaItems: flight.media)
                case .map:
                    FlightMap(camera: $camera, flight: flight)
                }
            }
            .padding(24)
        }
        .background(Color(hex: "#08090C").ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Header

private struct HeaderCard: View {
    let flight: Flight
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top) {
                OriginDestinationView(title: flight.origin, time: flight.departureTime, alignment: .leading)
                
                VStack(spacing: 4) {
                    Image(systemName: "airplane")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(Color(hex: "#1A1A1A"))
                        .padding(16)
                        .background(
                            Circle()
                                .fill(LinearGradient(colors: [Color.white, Color(hex: "#E3E6EA")], startPoint: .top, endPoint: .bottom))
                        )
                    Text(flight.duration)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color(hex: "#1A1A1A"))
                }
                .frame(maxWidth: .infinity)
                
                OriginDestinationView(title: flight.destination, time: flight.arrivalTime, alignment: .trailing)
            }
            
            Divider()
                .background(Color.white.opacity(0.2))
            
            HStack {
                CompanyLogo(name: domain(for: flight.airline))
                Spacer()
                FavoriteButton()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#F5F6F9"), Color(hex: "#D9DDE6")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
    }
}

private struct OriginDestinationView: View {
    let title: String
    let time: String
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment, spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color(hex: "#1A1A1A"))
                .lineLimit(2)
            Text(time)
                .font(.footnote)
                .foregroundStyle(Color(hex: "#3A3A3A"))
        }
        .frame(maxWidth: .infinity)
    }
}

private struct FavoriteButton: View {
    @State private var isFavorite = false
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isFavorite.toggle()
            }
        } label: {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(isFavorite ? Color(hex: "#FFD447") : Color(hex: "#1A1A1A"))
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.4))
                )
        }
    }
}

// MARK: - Info Grid

private struct InfoGrid: View {
    let flight: Flight
    
    var body: some View {
        VStack(spacing: 12) {
            Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                GridRow {
                    InfoTile(title: "Puerta (origen)", value: flight.gateOrigin)
                    InfoTile(title: "Puerta (destino)", value: flight.gateDestination)
                }
                GridRow {
                    InfoTile(title: "Número vuelo", value: flight.number)
                    InfoTile(title: "IATA", value: flight.iata)
                    InfoTile(title: "ICAO", value: flight.icao)
                }
                GridRow {
                    InfoTile(title: "Modelo aeronave", value: flight.aircraftModel, span: 2)
                    InfoTile(title: "Aerolínea", value: flight.airline)
                }
                GridRow {
                    InfoTile(title: "Matrícula", value: flight.registration)
                    InfoTile(title: "País", value: flight.country)
                    InfoTile(title: "Velocidad", value: flight.speed)
                }
                GridRow {
                    InfoTile(title: "Altura", value: flight.altitude, span: 3)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white.opacity(0.05))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
    }
}

private struct InfoTile: View {
    let title: String
    let value: String
    var span: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.6))
            Text(value)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .gridCellColumns(span)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.06))
        )
    }
}

// MARK: - Segment Picker

private struct SegmentPicker: View {
    @Binding var selected: FlightDetailView.Segment
    
    var body: some View {
        HStack(spacing: 12) {
            SegmentButton(title: "Aeronave", icon: "airplane", isSelected: selected == .aircraft) {
                selected = .aircraft
            }
            SegmentButton(title: "Mapa", icon: "map", isSelected: selected == .map) {
                selected = .map
            }
        }
        .padding(8)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.06))
        )
    }
}

private struct SegmentButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.subheadline.weight(.semibold))
                Text(title)
                    .font(.subheadline.weight(.semibold))
            }
            .foregroundStyle(isSelected ? Color(hex: "#1A1A1A") : Color.white.opacity(0.7))
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(
                        isSelected
                        ? LinearGradient(colors: [Color(hex: "#9C5CFF"), Color(hex: "#4C8CFF")], startPoint: .leading, endPoint: .trailing)
                        : Color.clear
                    )
            )
        }
    }
}

// MARK: - Aircraft Carousel

private struct AircraftCarousel: View {
    let mediaItems: [AircraftMedia]
    
    var body: some View {
        TabView {
            ForEach(mediaItems) { item in
                VStack(spacing: 16) {
                    AsyncImage(url: item.url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                            .tint(.white)
                    }
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    
                    Text(item.caption)
                        .font(.footnote)
                        .foregroundStyle(Color.white.opacity(0.7))
                }
                .padding(.horizontal, 8)
            }
        }
        .frame(height: 280)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
}

// MARK: - Map

private struct FlightMap: View {
    @Binding var camera: MapCameraPosition
    let flight: Flight
    
    var body: some View {
        Map(position: $camera) {
            Annotation(flight.number, coordinate: flight.coordinate) {
                VStack(spacing: 4) {
                    Image(systemName: "airplane.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color(hex: "#4C8CFF"))
                        .padding(10)
                        .background(.thinMaterial, in: Circle())
                    Text(flight.destination)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.black.opacity(0.6), in: Capsule())
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .frame(height: 280)
        .overlay(
            HStack {
                Spacer()
                VStack {
                    Button {
                        // Placeholder para ver mapa en pantalla completa
                    } label: {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.5), in: Circle())
                    }
                    .padding()
                    Spacer()
                }
            }
        )
    }
}

