//
//  GeoJSON.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 06.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    private(set) var quakes: [Quake] = []
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var featuresContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.features)
        
        while !featuresContainer.isAtEnd {
            let propertiesContainer = try featuresContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            if let properties = try? propertiesContainer.decodeIfPresent(Quake.self, forKey: FeatureCodingKeys.properties) {
                quakes.append(properties)
            }
            
        }
    }
}
