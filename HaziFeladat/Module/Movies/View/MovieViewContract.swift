import Foundation

protocol MovieViewContract: class {
    func setLoadingState(loading: Bool)
    func handleMovieError(error: String?)
    func displayMovies(_ movies: [MovieCellContent])
    func updateMovie(_ movie: MovieCellContent, atIndex: Int)
}
