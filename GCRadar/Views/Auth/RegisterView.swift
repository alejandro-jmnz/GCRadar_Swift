//
//  RegisterView.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI

/// Vista de registro de usuario
struct RegisterView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password, confirmPassword
    }
    
    // Validaciones en tiempo real
    private var isEmailValid: Bool {
        !email.isEmpty && email.contains("@") && email.contains(".")
    }
    
    private var isPasswordValid: Bool {
        password.count >= 6
    }
    
    private var doPasswordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }
    
    private var isFormValid: Bool {
        isEmailValid && isPasswordValid && doPasswordsMatch
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image("GCRadar_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text("Crear Cuenta")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Regístrate para comenzar")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                // Formulario
                VStack(spacing: 16) {
                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        TextField("tu@email.com", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .focused($focusedField, equals: .email)
                            .submitLabel(.next)
                        
                        if !email.isEmpty && !isEmailValid {
                            Text("Email no válido")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }
                    }
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Contraseña")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        SecureField("Mínimo 6 caracteres", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.newPassword)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.next)
                        
                        if !password.isEmpty {
                            if !isPasswordValid {
                                Text("La contraseña debe tener al menos 6 caracteres")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            } else {
                                Text("✓ Contraseña válida")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    // Confirm Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirmar Contraseña")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        SecureField("Repite tu contraseña", text: $confirmPassword)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.newPassword)
                            .focused($focusedField, equals: .confirmPassword)
                            .submitLabel(.go)
                        
                        if !confirmPassword.isEmpty {
                            if !doPasswordsMatch {
                                Text("Las contraseñas no coinciden")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            } else {
                                Text("✓ Las contraseñas coinciden")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    // Error message
                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    // Register button
                    Button {
                        Task {
                            await authViewModel.register(
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword
                            )
                        }
                    } label: {
                        HStack {
                            if authViewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Registrarse")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(isFormValid && !authViewModel.isLoading ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(!isFormValid || authViewModel.isLoading)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
            }
        }
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            case .password:
                focusedField = .confirmPassword
            case .confirmPassword:
                if isFormValid {
                    Task {
                        await authViewModel.register(
                            email: email,
                            password: password,
                            confirmPassword: confirmPassword
                        )
                    }
                }
            case .none:
                break
            }
        }
    }
}

#Preview {
    RegisterView(authViewModel: AuthViewModel())
}
