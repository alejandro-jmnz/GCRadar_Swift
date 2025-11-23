//
//  SerpApiViewModel.swift
//  GCRadar
//
//  Created by alumno on 23/11/25.
//

import Foundation

class SerpApiViewModel: ObservableObject {
    @Published var images: [SerpImage] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiKey = "072bd911d958605bb39feba77db0e2b1ef752ca2b4ac27fa5691fd35dd25f8cc"

    func searchImages(query: String) {
        guard let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        let urlString = "https://serpapi.com/search.json?engine=google_images_light&q=\(q)&api_key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data"
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(SerpImageResponse.self, from: data)
                DispatchQueue.main.async {
                    self.images = decoded.images_results
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding: \(error.localizedDescription)"
                }
            }

        }.resume()
    }
}
