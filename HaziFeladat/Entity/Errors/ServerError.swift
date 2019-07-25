//
//  ServerError.swift
//
//
//

import Foundation

class ServerError: ErrorProtocol {
    var message: String?

    init() {
        message = "Server error"
    }
}
