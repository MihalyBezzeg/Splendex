//
//  UITableViewController+Extension.swift
//  HaziFeladat
//
//  Copyright © 2019. Bezzeg Mihály. All rights reserved.
//

import UIKit

protocol ConfigurableTableView: class {
    var tableView: UITableView! { get }
    var cells: [CellConfiguratorType] { get set }
}

extension ConfigurableTableView where Self: UIViewController {
    internal func registerCells() {
        for cell in cells {
            tableView.register(cell.cellNib, forCellReuseIdentifier: cell.reuseIdentifier)
        }

        tableView.reloadData()
    }
}
