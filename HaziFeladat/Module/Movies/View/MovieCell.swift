//
//  MovieCell.swift
//  HaziFeladat
//
//  Created by Bezzeg Mihály on 2019. 07. 25..
//  Copyright © 2019. Bezzeg Mihály. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieCellContent {
    let title: String
    let imageURL: URL?
    var budget: Int?

    init(title: String, imageURL: URL? = nil, budget: Int? = nil) {
        self.title = title
        self.imageURL = imageURL
        self.budget = budget
    }
}

class MovieCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var budgetLabel: UILabel!
}

// MARK: - Updatable
extension MovieCell: Updatable {
    typealias ViewData = MovieCellContent

    func update(_ viewData: MovieCellContent) {
        let placeholder = UIImage(named: "movie_placeholder")
        titleLabel.text = viewData.title
        movieImage.sd_setImage(with: viewData.imageURL,
                               placeholderImage: placeholder,
                               options: .scaleDownLargeImages,
                               context: nil,
                               progress: nil,
                               completed: nil)
        if let budget = viewData.budget {
            budgetLabel.text = "Budget: \(budget)"
        } else {
            budgetLabel.text = "Budget: Loading..."
        }
    }
}
