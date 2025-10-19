//
//  ParkRow.swift
//  Parks-iOS102
//
//  Created by Jon Toussaint on 10/19/25.
//

import SwiftUI

struct ParkRow: View {
    let park: Park

    var body: some View {
        // Park row
        Rectangle()
            .aspectRatio(16/9, contentMode: .fit)
            .overlay {
                let image = park.images.first
                let urlString = image?.url
                let url = urlString.flatMap { URL(string: $0) }

                AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color(.systemGray4)
                    }
            }
            .overlay(alignment: .bottomLeading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
            }
            .cornerRadius(16)
            .padding(.horizontal)
    }
}
