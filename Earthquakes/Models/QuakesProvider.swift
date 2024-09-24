//
//  QuakesProvider.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 24.09.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

@MainActor
class QuakesProvider: ObservableObject {

    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuake(at indexSet: IndexSet) {
        self.quakes.remove(atOffsets: indexSet)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
    
}
