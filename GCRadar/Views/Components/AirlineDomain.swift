//
//  AirlineDomain.swift
//  GCRadar
//
//  Created by alumno on 11/11/25.
//


/*
 
 A la API que carga el logotipo hay que pasarle un dominio.
 Por ello creamos esta funcion que convierte el nombre de la aerolinea a un dominio web
 
 */

import Foundation

func domain(for airline: String) -> String {
    // 1. Minusculas
    var name = airline.lowercased()
    
    // 2. Quitar acentos
    name = name.folding(options: .diacriticInsensitive, locale: .current)
    
    // 3. Quitar caracteres no alfanuméricos
    name = name.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    
    // 4. Añadir extensión genérica
    return "\(name).com"
}
