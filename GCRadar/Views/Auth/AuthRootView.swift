//
//  AuthRootView.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI

/// Vista raíz de autenticación que gestiona Login y Register
struct AuthRootView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var isLoginMode = true
    
    var body: some View {
        VStack(spacing: 0) {
            if isLoginMode {
                LoginView(authViewModel: authViewModel)
            } else {
                RegisterView(authViewModel: authViewModel)
            }
            
            // Toggle entre Login y Register
            HStack {
                Text(isLoginMode ? "¿No tienes cuenta?" : "¿Ya tienes cuenta?")
                    .foregroundColor(.secondary)
                
                Button(isLoginMode ? "Regístrate" : "Inicia Sesión") {
                    withAnimation {
                        isLoginMode.toggle()
                        authViewModel.errorMessage = nil
                    }
                }
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            }
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    AuthRootView(authViewModel: AuthViewModel())
}
