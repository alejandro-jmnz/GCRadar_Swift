//
//  SerpImageResult.swift
//  GCRadar
//
//  Created by alumno on 23/11/25.
//

import Foundation

struct SerpImageResponse: Codable {
    let images_results: [SerpImage]
}

struct SerpImage: Codable, Identifiable {
    let id = UUID()          // No viene en el JSON, lo creamos
    let position: Int?
    let thumbnail: String?
    let title: String?
    let original: String?
}
