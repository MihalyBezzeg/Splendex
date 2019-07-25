import Foundation
import Moya
import SDWebImage

class MoviePresenter {
    // MARK: - Properties
    var movieProvider: MovieProviderContract!
    var router: RouterContract
    weak var view: MovieViewContract!

    private var lastMovieResult: [Movie] = []

    // MARK: - Initializers
    init(view: MovieViewContract, router: RouterContract, movieProvider: MovieProviderContract) {
        self.view = view
        self.router = router
        self.movieProvider = movieProvider
    }
}

// MARK: - MoviePresenterContract
extension MoviePresenter: MoviePresenterContract {
    func viewDidLoad() {}

    func getMovies(query: String?) {
        guard let query = query else {
            return
        }

        view.setLoadingState(loading: true)
        view.handleMovieError(error: nil)

        movieProvider.getMovies(query: query) { [weak self] (result: MovieResult?, error: ErrorProtocol?) in
            guard let self = self else {
                return
            }

            self.view.setLoadingState(loading: false)
            if let movieResult = result {
                self.lastMovieResult = movieResult.results
                self.view.displayMovies(self.createMovieContent(movieResult))
            } else {
                self.view.handleMovieError(error: error?.message)
            }
        }
    }

    func getMovieDetails(forMovie movie: Movie) {
        movieProvider.getMovieDetails(forMovie: movie) { [weak self] (details: MovieDetails?, error: ErrorProtocol?) in
            guard let self = self else {
                return
            }

            if let detailsResult = details {
                let index = self.lastMovieResult.index(where: { (currentMovie) -> Bool in
                    currentMovie.id == movie.id
                })
                if let indexToUpdate = index {
                    let content = self.assembleContent(forMovie: movie,
                                                       budget: detailsResult.budget)
                    self.view.updateMovie(content, atIndex: indexToUpdate)
                }

            }
        }
    }

    private func createMovieContent(_ movieResult: MovieResult) -> [MovieCellContent] {
        var retArray: [MovieCellContent] = []
        for currentMovie in movieResult.results {
            self.getMovieDetails(forMovie: currentMovie)
            let content = self.assembleContent(forMovie: currentMovie,
                                               budget: nil)

            retArray.append(content)
        }

        return retArray
    }

    private func assembleContent(forMovie movie: Movie, budget: Int?) -> MovieCellContent {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path)
        return MovieCellContent(title: movie.title,
                                imageURL: imageURL,
                                budget: budget)
    }
}
