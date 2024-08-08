//
//  HTTPDataDownloader.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 08.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

let validStatus = 200...299

protocol HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await data(from: url) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw QuakeError.networkError
        }
        return data
    }
    
    
}
