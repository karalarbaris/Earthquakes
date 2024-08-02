//
//  QuakeError.swift
//  Earthquakes-iOS
//
//  Created by Baris Karalar on 02.08.24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

enum QuakeError: Error, LocalizedError {
    case missingData
    
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Missing data", comment: "comment!")
        }
    }
}
