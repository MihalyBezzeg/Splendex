import UIKit

protocol RouterContract {
    func presentMovies()
}

class Router {
    // MARK: - Properties
    private weak var window: UIWindow?

    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
    }
}

extension Router: RouterContract {
    func presentMovies() {
        let view = MoviesViewController()
        let navController = UINavigationController(rootViewController: view)
        let presenter = MoviePresenter(view: view,
                                       router: self,
                                       movieProvider: MovieProvider())
        view.presenter = presenter

        window?.rootViewController = navController
    }
}
