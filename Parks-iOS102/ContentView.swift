//
//  ContentView.swift
//  Parks-iOS102
//
//  Created by Jon Toussaint on 10/19/25.
//

import SwiftUI

struct ContentView: View {

    static let API_KEY = ProcessInfo.processInfo.environment["API_KEY"]!

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // Create a Task instance
            Task {
                // URL for the API endpoint
                // 👋👋👋 Make sure to replace {YOUR_API_KEY} in the URL with your actual NPS API Key
                // Pass in any state code you like for the stateCode parameter. For instance, stateCode=fl (Florida)
                let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=wa&api_key=\(Self.API_KEY)")!

                do {
                    // Perform an asynchronous data request using URLSession
                    let (data, _) = try await URLSession.shared.data(from: url)

                    // Print the JSON
                    // Convert data to JSON object
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    // Convert JSON object back to pretty-printed data
                    let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    // Convert data to string for printing
                    if let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
                        print(prettyPrintedString)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
