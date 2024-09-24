//
//  TestDownloader.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 12.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(for: .seconds(Int.random(in: 1...2)))
        return testQuakesData
    }
    
    
}
