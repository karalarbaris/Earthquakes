/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A structure for representing quake data.
*/

import Foundation

struct Quake {
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
}

extension Quake: Identifiable {
    var id: String { code }
}

extension Quake: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
        case code
        case detail
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let magnitude = try? values.decode(Double.self, forKey: .magnitude)
        let place = try? values.decode(String.self, forKey: .place)
        let time = try? values.decode(Date.self, forKey: .time)
        let code = try? values.decode(String.self, forKey: .code)
        let detail = try? values.decode(URL.self, forKey: .detail)
        
        guard let magnitude = magnitude,
              let place = place,
              let time = time,
              let code = code,
              let detail = detail
        else {
            throw QuakeError.missingData
        }
        
        self.magnitude = magnitude
        self.place = place
        self.time = time
        self.code = code
        self.detail = detail
    }
    
    
    
}
