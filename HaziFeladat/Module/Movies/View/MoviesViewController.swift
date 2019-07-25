import UIKit

class MoviesViewController: BaseConfigurableTableView {
    // MARK: - Outlets
    @IBOutlet fileprivate weak var searchButton: UIButton!
    @IBOutlet fileprivate weak var searchTextField: UITextField!

    // MARK: - Properties
    var presenter: MoviePresenterContract!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.title = "Movies"
    }

    private func setupCells(_ movies: [MovieCellContent]) {
        cells = []

        for currentMovie in movies {
            let content = MovieCellContent(title: currentMovie.title,
                                           imageURL: currentMovie.imageURL,
                                           budget: currentMovie.budget)
            let configurator = CellConfigurator<MovieCell>(viewData: content)
            cells.append(configurator)
        }

        registerCells()
    }

     // MARK: - Actions
    @IBAction func searchButtonPressed(_ sender: Any) {
        self.presenter.getMovies(query: self.searchTextField.text)
    }

}

// MARK: - MovieViewContract
extension MoviesViewController: MovieViewContract {
    func setLoadingState(loading: Bool) {
    }

    func displayMovies(_ movies: [MovieCellContent]) {
        self.setupCells(movies)
    }

    func updateMovie(_ movie: MovieCellContent, atIndex: Int) {
        cells[atIndex] = CellConfigurator<MovieCell>(viewData: movie)
        let indexPath = IndexPath(row: atIndex, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func handleMovieError(error: String?) {
        guard let error = error else {
            return
        }

        let alert = UIAlertController(title: "Oops...", message: error,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
