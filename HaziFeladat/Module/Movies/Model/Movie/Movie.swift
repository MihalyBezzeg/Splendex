//
//  Users.swift
//
//
//

import Foundation

struct Movie: Codable {
    var id: Int
    var poster_path: String
    var title: String

    enum CodingKeys: String, CodingKey {
        case id, poster_path, title
    }
}
