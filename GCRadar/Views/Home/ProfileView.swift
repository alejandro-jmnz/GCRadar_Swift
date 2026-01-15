//
//  ProfileView.swift
//  GCRadar
//
//  Created by alumno on 9/1/26.
//

import SwiftUI

/// Vista de perfil del usuario con opción de cerrar sesión
struct ProfileView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header con información del usuario
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    if let email = authViewModel.currentUser?.email {
                        Text(email)
                            .font(.headline)
                            .foregroundColor(.primary)
                    } else {
                        Text("Usuario")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Botón de cerrar sesión
                Button {
                    authViewModel.logout()
                } label: {
                    HStack {
                        Image(systemName: "arrow.right.square")
                        Text("Cerrar Sesión")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .navigationTitle("Perfil")
        }
    }
}

