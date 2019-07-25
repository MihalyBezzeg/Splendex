import Foundation

protocol MoviePresenterContract: class {
    func viewDidLoad()
    func getMovies(query: String?)
}
