//
//  LoginView.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI

/// Vista de inicio de sesión
struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 8) {
                Image(systemName: "airplane.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("GCRadar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Inicia sesión para continuar")
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
                }
                
                // Password field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Contraseña")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.go)
                }
                
                // Error message
                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                // Login button
                Button {
                    Task {
                        await authViewModel.login(email: email, password: password)
                    }
                } label: {
                    HStack {
                        if authViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Iniciar Sesión")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(authViewModel.isLoading || email.isEmpty || password.isEmpty)
                .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            case .password:
                Task {
                    await authViewModel.login(email: email, password: password)
                }
            case .none:
                break
            }
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}
