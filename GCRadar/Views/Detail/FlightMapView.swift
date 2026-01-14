//
//  FlightMapView.swift
//  GCRadar
//
//  Muestra la posición actual del vuelo en un mapa de Google Maps.
//

import SwiftUI
import GoogleMaps
import CoreLocation

struct FlightMapView: UIViewRepresentable {
    let latitude: Double
    let longitude: Double

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = false
        mapView.settings.zoomGestures = true
        mapView.settings.scrollGestures = true

        addMarker(on: mapView)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: uiView.camera.zoom)
        uiView.animate(to: camera)

        uiView.clear()
        addMarker(on: uiView)
    }

    private func addMarker(on mapView: GMSMapView) {
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: .systemBlue)
        marker.title = "Posición actual"
        marker.snippet = "Lat: \(String(format: "%.2f", latitude)), Lon: \(String(format: "%.2f", longitude))"
        marker.map = mapView
    }
}

