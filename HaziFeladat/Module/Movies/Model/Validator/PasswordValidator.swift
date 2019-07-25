//
//  PasswordValidator.swift
//
//
//

import Foundation

class PasswordValidator: ValidationProtocol {
    func isValid(testStr: String?) -> String? {
        guard let password = testStr, !password.isEmpty else {
            return "Password can not be empty"
        }

        return nil
    }
}
