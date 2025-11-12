//
//  MainTabView.swift
//  GCRadar
//
//  Created by alumno on 6/11/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .departures
    @State private var showFiltersSheet = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .departures:
                    NavigationStack {
                        DeparturesView()
                            .navigationBarHidden(true)
                    }
                case .arrivals:
                    PlaceholderScreen(
                        icon: "airplane.arrival",
                        title: "Llegadas",
                        message: "Pronto podrás seguir los aterrizajes en tiempo real."
                    )
                case .airspace:
                    PlaceholderScreen(
                        icon: "airplane.circle",
                        title: "Espacio aéreo",
                        message: "Explora el tráfico que sobrevuela Gran Canaria."
                    )
                case .favorites:
                    PlaceholderScreen(
                        icon: "star.fill",
                        title: "Favoritos",
                        message: "Guarda aquí los vuelos que más te interesan."
                    )
                }
            }
            .ignoresSafeArea()
            
            CustomTabBar(selectedTab: $selectedTab, filterAction: {
                showFiltersSheet.toggle()
            })
        }
        .sheet(isPresented: $showFiltersSheet) {
            FiltersSheet()
        }
    }
}

// MARK: - Tabs

private enum Tab: CaseIterable {
    case departures
    case arrivals
    case airspace
    case favorites
    
    var title: String {
        switch self {
        case .departures: return "Salidas"
        case .arrivals: return "Llegadas"
        case .airspace: return "Espacio aéreo"
        case .favorites: return "Favoritos"
        }
    }
    
    var icon: String {
        switch self {
        case .departures: return "airplane.departure"
        case .arrivals: return "airplane.arrival"
        case .airspace: return "airplane.circle"
        case .favorites: return "star"
        }
    }
}

// MARK: - Custom Tab Bar

private struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    let filterAction: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.white.opacity(0.1))
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color.black.opacity(0.3))
                        .blur(radius: 30)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .frame(height: 74)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            
            HStack(spacing: 40) {
                TabButton(tab: .departures, selectedTab: $selectedTab)
                TabButton(tab: .arrivals, selectedTab: $selectedTab)
                
                Button(action: filterAction) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#FFDD33"))
                            .frame(width: 64, height: 64)
                            .shadow(color: Color(hex: "#FFDD33").opacity(0.6), radius: 12, y: 4)
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(Color(hex: "#1A1A1A"))
                    }
                }
                .offset(y: -30)
                
                TabButton(tab: .airspace, selectedTab: $selectedTab)
                TabButton(tab: .favorites, selectedTab: $selectedTab)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
}

private struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 6) {
                Image(systemName: tab.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .symbolVariant(selectedTab == tab ? .fill : .none)
                Text(tab.title)
                    .font(.caption2.weight(.medium))
            }
            .foregroundStyle(selectedTab == tab ? Color.white : Color.white.opacity(0.6))
        }
    }
}

// MARK: - Placeholder Screens

private struct PlaceholderScreen: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        ZStack {
            Color(hex: "#121212").ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 48, weight: .thin))
                    .foregroundStyle(Color.white.opacity(0.6))
                Text(title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.6))
                    .frame(maxWidth: 260)
            }
            .padding(.bottom, 80)
        }
    }
}

// MARK: - Filters Sheet

private struct FiltersSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Mostrar vuelos") {
                    Toggle("Solo aerolíneas canarias", isOn: .constant(true))
                    Toggle("Directos a península", isOn: .constant(false))
                    Toggle("Compromiso puntualidad", isOn: .constant(true))
                }
                
                Section("Ordenar por") {
                    Picker("Orden", selection: .constant(0)) {
                        Text("Hora de salida").tag(0)
                        Text("Tiempo estimado").tag(1)
                        Text("Puerta").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Filtros")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    MainTabView()
}
