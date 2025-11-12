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
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white.opacity(0.08))
                ProgressView()
                    .tint(.white)
            }
        }
        .frame(width: 70, height: 40)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white.opacity(0.06))
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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
