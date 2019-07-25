//
//  GenericError.swift
//
//
//

import Foundation

class GenericError: ErrorProtocol {
    var message: String?

    init() {
        message = "Something went wrong"
    }
}
