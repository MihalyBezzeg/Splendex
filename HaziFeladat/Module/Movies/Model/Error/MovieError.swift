//
//
//
//

import Foundation

struct MovieError: Codable, ErrorProtocol {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message
    }
}
