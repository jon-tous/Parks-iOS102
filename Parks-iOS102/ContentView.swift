//
//  ContentView.swift
//  Parks-iOS102
//
//  Created by Jon Toussaint on 10/19/25.
//

import SwiftUI


struct ContentView: View {
    
    @State private var parks: [Park] = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(parks) { park in
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
        }
        .onAppear {
            Task {
                await fetchParks()
            }
        }
    }
    
    private func fetchParks() async {
        // URL for the API endpoint
        // 👋👋👋 Make sure to replace {YOUR_API_KEY} in the URL with your actual NPS API Key
        let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=ca&api_key=\(Self.API_KEY)")!
        do {
            
            // Perform an asynchronous data request
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode json data into ParksResponse type
            let parksResponse = try JSONDecoder().decode(ParksResponse.self, from: data)
            
            // Get the array of parks from the response
            let parks = parksResponse.data
            
            // Print the full name of each park in the array
            for park in parks {
                print(park.fullName)
            }
            
            // Set the parks state property
            self.parks = parks
            
        } catch {
            print(error.localizedDescription)
        }
    }
    static let API_KEY = ProcessInfo.processInfo.environment["API_KEY"]!
}

#Preview {
    ContentView()
}
