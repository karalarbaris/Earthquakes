//
//  QuakeLocation.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 06.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

struct QuakeLocation: Decodable {
    
    var latitude: Double {
        properties.products.origin.first!.properties.latitude
    }
    var longitude: Double {
        properties.products.origin.first!.properties.longitude
    }
    private var properties: QuakeLocationProperties
    
    struct QuakeLocationProperties: Decodable {
        var products: Products
    }
    
    struct Products: Decodable {
        var origin: [Origin]
    }
    
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    
    struct OriginProperties: Decodable {
        var latitude: Double
        var longitude: Double
    }
    
}

extension QuakeLocation.OriginProperties {
    
    private enum OriginPropertiesCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
        let longitude = try container.decode(String.self, forKey: .longitude)
        let latitude = try container.decode(String.self, forKey: .latitude)
        guard let longitude = Double(longitude),
              let latitude = Double(latitude) else {
            throw QuakeError.missingData
        }
        self.longitude = longitude
        self.latitude = latitude
        
    }
    
}
