//
//  UIViewController+Extension.swift
//
//
//

import UIKit

extension UIViewController {
    func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
