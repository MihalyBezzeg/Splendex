//
//  EmailValidator.swift
//
//
//

import Foundation

class EmailValidator: ValidationProtocol {
    func isValid(testStr: String?) -> String? {
        guard let email = testStr else {
            return "E-mail can not be empty"
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email) ? nil : "Invalid e-mail address"
    }
}
