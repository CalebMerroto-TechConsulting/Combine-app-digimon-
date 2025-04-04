//
//  Digimon Image.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/5/25.
//

import SwiftUI

struct DigimonImage: View {
    var digimon: Digimon
    var size: CGFloat
    var shadowColor: Color = Color.gray
    var body: some View {
        AsyncImage(url: digimon.src) { phase in
            switch phase {
            case .empty:
                ProgressView()
                        .frame(width: size, height: size)
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: size * 0.1))
                    .shadow(color: shadowColor,radius: size * 0.1)
            case .failure:
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    DigimonImage(
        digimon: Digimon(
            name: "Greymon",
            level: "In Training",
            img: "https://digimon.shadowsmith.com/img/greymon.jpg"
        ),
        size: 280
    )
        
}
