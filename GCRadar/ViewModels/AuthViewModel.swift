//
//  AuthViewModel.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI
import FirebaseAuth

/// ViewModel para manejar la autenticación de usuarios con Firebase
@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentUser: User?
    
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
                self?.currentUser = user
                self?.isAuthenticated = user != nil
            }
        }
    }
    
    /// Registra un nuevo usuario
    /// - Parameters:
    ///   - email: Email del usuario
    ///   - password: Contraseña del usuario
    ///   - confirmPassword: Confirmación de contraseña
    func register(email: String, password: String, confirmPassword: String) async {
        // Validaciones locales
        guard isValidEmail(email) else {
            errorMessage = AuthError.invalidEmail.errorDescription
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = AuthError.passwordTooShort.errorDescription
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = AuthError.passwordsDoNotMatch.errorDescription
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // El listener actualizará automáticamente isAuthenticated
            isLoading = false
        } catch {
            errorMessage = AuthError.fromFirebaseError(error).errorDescription
            isLoading = false
        }
    }
    
    /// Inicia sesión con email y contraseña
    /// - Parameters:
    ///   - email: Email del usuario
    ///   - password: Contraseña del usuario
    func login(email: String, password: String) async {
        // Validación básica
        guard isValidEmail(email) else {
            errorMessage = AuthError.invalidEmail.errorDescription
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Por favor ingresa tu contraseña"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // El listener actualizará automáticamente isAuthenticated
            isLoading = false
        } catch {
            errorMessage = AuthError.fromFirebaseError(error).errorDescription
            isLoading = false
        }
    }
    
    /// Cierra la sesión del usuario actual
    func logout() {
        do {
            try Auth.auth().signOut()
            // El listener actualizará automáticamente isAuthenticated
            errorMessage = nil
        } catch {
            errorMessage = "Error al cerrar sesión: \(error.localizedDescription)"
        }
    }
    
    /// Valida si un email tiene formato válido
    /// - Parameter email: Email a validar
    /// - Returns: true si el email es válido
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
