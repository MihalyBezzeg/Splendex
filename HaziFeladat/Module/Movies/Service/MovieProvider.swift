//
//  Test.swift
//
//
//

import Foundation
import Moya

class MovieProvider: MovieProviderContract {
    func getMovies(query: String,
                   callback:@escaping (MovieResult?, ErrorProtocol?) -> Void) {
        let provider = MoyaProvider<MovieAPIService>()
        provider.request(.getMovies(query)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode

                do {
                    let decoder = JSONDecoder()
                    if statusCode == 200 {
                        let moviResult = try decoder.decode(MovieResult.self, from: data)
                        callback(moviResult, nil)
                    } else {
                        let error = try decoder.decode(MovieError.self, from: data)
                        callback(nil, error)
                    }
                }
                catch {
                    callback(nil, GenericError())
                }
            case .failure(_):
                callback(nil, ServerError())
            }
        }
    }

    func getMovieDetails(forMovie movie: Movie,
                         callback:@escaping (MovieDetails?, ErrorProtocol?) -> Void) {
        let provider = MoyaProvider<MovieAPIService>()
        provider.request(.getMovieDetails(movie.id)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode

                do {
                    let decoder = JSONDecoder()
                    if statusCode == 200 {
                        let details = try decoder.decode(MovieDetails.self, from: data)
                        callback(details, nil)
                    } else {
                        let error = try decoder.decode(MovieError.self, from: data)
                        callback(nil, error)
                    }
                }
                catch {
                    callback(nil, GenericError())
                }
            case .failure(_):
                callback(nil, ServerError())
            }
        }
    }
}
