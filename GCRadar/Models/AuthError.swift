//
//  AuthError.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import Foundation
import FirebaseAuth

/// Enum para manejar errores de autenticación con mensajes legibles
enum AuthError: LocalizedError {
    case invalidEmail
    case passwordTooShort
    case passwordsDoNotMatch
    case weakPassword
    case emailAlreadyInUse
    case userNotFound
    case wrongPassword
    case networkError
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "El email no es válido"
        case .passwordTooShort:
            return "La contraseña debe tener al menos 6 caracteres"
        case .passwordsDoNotMatch:
            return "Las contraseñas no coinciden"
        case .weakPassword:
            return "La contraseña es demasiado débil"
        case .emailAlreadyInUse:
            return "Este email ya está registrado"
        case .userNotFound:
            return "Usuario no encontrado"
        case .wrongPassword:
            return "Contraseña incorrecta"
        case .networkError:
            return "Error de conexión. Verifica tu internet"
        case .unknownError(let message):
            return "Error: \(message)"
        }
    }
    
    /// Convierte errores de Firebase a AuthError
    static func fromFirebaseError(_ error: Error) -> AuthError {
        let nsError = error as NSError
        guard let errorCode = AuthErrorCode(rawValue: nsError.code) else {
            return .unknownError(error.localizedDescription)
        }
        
        switch errorCode {
        case .invalidEmail:
            return .invalidEmail
        case .weakPassword:
            return .weakPassword
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .userNotFound:
            return .userNotFound
        case .wrongPassword:
            return .wrongPassword
        case .networkError:
            return .networkError
        default:
            return .unknownError(error.localizedDescription)
        }
    }
}
