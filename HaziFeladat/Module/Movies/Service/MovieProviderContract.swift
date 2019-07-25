//
//
//
//

import Foundation
import Moya

protocol MovieProviderContract {
    func getMovies(query: String,
                   callback:@escaping (MovieResult?, ErrorProtocol?) -> Void)
    func getMovieDetails(forMovie movie: Movie,
                         callback:@escaping (MovieDetails?, ErrorProtocol?) -> Void)
}
