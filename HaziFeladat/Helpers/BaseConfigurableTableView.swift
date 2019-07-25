//
//  BaseConfigurableTableView.swift
//
//
//  Copyright © 2019. All rights reserved.
//

import UIKit

class BaseConfigurableTableView: UIViewController, ConfigurableTableView {
    // MARK: - Outlets
    @IBOutlet internal weak var tableView: UITableView!

    var cells: [CellConfiguratorType] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }

    // MARK: - Internal methods
    internal func setupTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none

        if #available(iOS 11, *) {
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.rowHeight = UITableView.automaticDimension
        } else {
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDataSource
extension BaseConfigurableTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = cells[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)

        cell.selectionStyle = .none
        cellConfigurator.updateCell(cell)

        return cell
    }
}
