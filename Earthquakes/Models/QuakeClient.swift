//
//  QuakeClient.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 08.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

class QuakeClient {
    
    var quakes: [Quake] {
        get async throws {
//            fatalError("Unimplemented")
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            return allQuakes.quakes
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
}
