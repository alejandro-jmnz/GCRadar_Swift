//
//  FavoritesViewModel.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

/// ViewModel para manejar los vuelos favoritos del usuario
@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoriteFlightNumbers: Set<String> = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        // Escuchar cambios en el estado de autenticación
        setupAuthListener()
    }
    
    deinit {
        // Remover el listener cuando se destruya el ViewModel
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    /// Configura el listener para cambios en el estado de autenticación
    private func setupAuthListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                if user != nil {
                    // Usuario autenticado, cargar favoritos
                    await self?.loadFavoriteFlightNumbers()
                } else {
                    // Usuario cerró sesión, limpiar favoritos
                    self?.favoriteFlightNumbers = []
                }
            }
        }
    }
    
    private var favoritesCollection: CollectionReference? {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        return db.collection("users").document(uid).collection("favorites")
    }
    
    
    /// Añade un número de vuelo a favoritos
    /// - Parameters:
    ///   - flightNumber: Número de vuelo a añadir
    ///   - airline: Nombre de la aerolínea (opcional)
    func addFavoriteFlightNumber(_ flightNumber: String, airline: String? = nil) async {
        guard let favoritesCollection = favoritesCollection else {
            errorMessage = "No hay usuario autenticado"
            return
        }
        
        
        isLoading = true
        errorMessage = nil
        
        do {
            // El ID del documento es el propio flightNumber
            let favoriteRef = favoritesCollection.document(flightNumber)
            
            var data: [String: Any] = [
                "flightNumber": flightNumber,
                "createdAt": FieldValue.serverTimestamp()
            ]
            
            if let airline = airline {
                data["airline"] = airline
            }
            
            try await favoriteRef.setData(data)
            
            // Actualizar el Set en memoria
            favoriteFlightNumbers.insert(flightNumber)
            isLoading = false
        } catch {
            errorMessage = "Error al añadir favorito: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    /// Elimina un número de vuelo de favoritos
    /// - Parameter flightNumber: Número de vuelo a eliminar
    func removeFavoriteFlightNumber(_ flightNumber: String) async {
        guard let favoritesCollection = favoritesCollection else {
            errorMessage = "No hay usuario autenticado"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await favoritesCollection.document(flightNumber).delete()
            
            // Actualizar el Set en memoria
            favoriteFlightNumbers.remove(flightNumber)
            isLoading = false
        } catch {
            errorMessage = "Error al eliminar favorito: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    /// Carga todos los números de vuelo favoritos del usuario
    /// - Returns: Set con los números de vuelo favoritos normalizados
    func loadFavoriteFlightNumbers() async -> Set<String> {
        guard let favoritesCollection = favoritesCollection else {
            errorMessage = "No hay usuario autenticado"
            favoriteFlightNumbers = []
            return []
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let snapshot = try await favoritesCollection.getDocuments()
            let flightNumbers = Set(snapshot.documents.compactMap { doc -> String? in
                return doc.data()["flightNumber"] as? String ?? doc.documentID
            })
            
            favoriteFlightNumbers = flightNumbers
            isLoading = false
            return flightNumbers
        } catch {
            errorMessage = "Error al cargar favoritos: \(error.localizedDescription)"
            isLoading = false
            return []
        }
    }
    
    /// Verifica si un número de vuelo está en favoritos
    /// - Parameter flightNumber: Número de vuelo a verificar
    /// - Returns: true si el vuelo está en favoritos
    func isFavoriteFlight(_ flightNumber: String) -> Bool {
        return favoriteFlightNumbers.contains(flightNumber)
    }
    
    /// Alterna el estado de favorito de un vuelo
    /// - Parameters:
    ///   - flightNumber: Número de vuelo a alternar
    ///   - airline: Nombre de la aerolínea (opcional)
    func toggleFavorite(_ flightNumber: String, airline: String? = nil) async {
        if isFavoriteFlight(flightNumber) {
            await removeFavoriteFlightNumber(flightNumber)
        } else {
            await addFavoriteFlightNumber(flightNumber, airline: airline)
        }
    }
}
