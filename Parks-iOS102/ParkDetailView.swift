//
//  ParkDetailView.swift
//  Parks-iOS102
//
//  Created by Jon Toussaint on 10/19/25.
//

import SwiftUI

struct ParkDetailView: View {
    let park: Park
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(park.fullName)
                    .font(.largeTitle)
                Text(park.description)
            }
            .padding()
            
            // TODO: Add horizontal scrolling images
        }
    }
}

#Preview {
    ParkDetailView(park: Park.mocked)
}
