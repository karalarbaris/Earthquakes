//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Baris Karalar on 02.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import XCTest
@testable import Earthquakes

final class EarthquakesTests: XCTestCase {

    func testGeoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: test_feature_1)
        
        XCTAssertEqual(quake.code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testGeoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let geoJSON = try decoder.decode(GeoJSON.self, from: testQuakesData)
        
        XCTAssertEqual(geoJSON.quakes.count, 6)
        XCTAssertEqual(geoJSON.quakes[0].code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = geoJSON.quakes[0].time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testQuakeDetailsDecoder() throws {
        let decoder = JSONDecoder()
        let details = try decoder.decode(QuakeLocation.self, from: testDetail_hv72783692)
        XCTAssertEqual(details.latitude, 19.2189998626709)
        XCTAssertEqual(details.longitude, -155.434173583984) 
    }
    
    func testClientDoesFetchEarthquakeData() async throws {
        let downloader = TestDownloader()
        let client = QuakeClient(downloader: downloader)

        let quakes = try await client.quakes
        
        XCTAssertEqual(quakes.count, 6)
        
        
    }
    
}
