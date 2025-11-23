//
//  ImageCarouselView.swift
//  GCRadar
//
//  Created by alumno on 23/11/25.
//

import SwiftUI

struct ImageCarouselView: View {
    @StateObject private var viewModel = SerpApiViewModel()
        var query: String

        var body: some View {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    if viewModel.images.isEmpty {
                        Text("No se encontraron imágenes")
                    } else {
                        TabView {
                            ForEach(viewModel.images) { item in
                                AsyncImage(url: URL(string: item.original ?? item.thumbnail ?? "")) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxHeight: 300)
                                            .cornerRadius(12)
                                            .padding()
                                    case .failure(_):
                                        Color.gray
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(height: 320)
                    }
                }
            }
            .onAppear {
                viewModel.searchImages(query: query)
            }
        }
}

