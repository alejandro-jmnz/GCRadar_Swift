//
//  CompanyLogo.swift
//  GCRadar
//
//  Created by alumno on 11/11/25.
//

import SwiftUI

let LOGO_DEV_PUBLIC_KEY = "pk_Ui1Nf0MJTy6rKfHgxxBEpg"

struct CompanyLogo: View {
    let name: String

    var body: some View {
        AsyncImage(url: URL(string: "https://img.logo.dev/\(name)?token=\(LOGO_DEV_PUBLIC_KEY)")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 40, height: 40)
    }
}
/*
// Using URLSession for direct download
func downloadCompanyLogo(name: String) async throws -> Data {
    let url = URL(string: "https://img.logo.dev/\(name)?token=\(LOGO_DEV_PUBLIC_KEY)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
*/
