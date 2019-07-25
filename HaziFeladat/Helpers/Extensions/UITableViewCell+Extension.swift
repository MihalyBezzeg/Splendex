//
//  UITableViewCell+Extension.swift
//  HaziFeladat
//
//  Copyright © 2019. Bezzeg Mihály. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self),
                     bundle: Bundle.main)
    }

    class func reuseIdentiferFromName() -> String {
        return NSStringFromClass(self)
    }
}

protocol Updatable: class {

    associatedtype ViewData

    func update(_ viewData: ViewData)
}


protocol CellConfiguratorType {

    var reuseIdentifier: String { get }
    var cellNib: UINib { get }
    var cellClass: AnyClass { get }

    func updateCell(_ cell: UITableViewCell)
}

struct CellConfigurator<Cell> where Cell: Updatable, Cell: UITableViewCell {

    var viewData: Cell.ViewData
    let reuseIdentifier: String = Cell.reuseIdentiferFromName()
    let cellClass: AnyClass = Cell.self
    let cellNib: UINib = Cell.nib()

    func updateCell(_ cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.update(viewData)
        }
    }
}

extension CellConfigurator: CellConfiguratorType {}
