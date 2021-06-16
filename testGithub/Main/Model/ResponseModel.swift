// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseModel = try? newJSONDecoder().decode(ResponseModel.self, from: jsonData)

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
