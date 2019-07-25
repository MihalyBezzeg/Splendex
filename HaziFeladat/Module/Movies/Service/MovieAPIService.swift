//
//
//
//

import Foundation
import Moya

enum MovieAPIService {
    case getMovies(String)
    case getMovieDetails(Int)
}

extension MovieAPIService: TargetType {
    var kAPIKey: String {
        return "43a7ea280d085bd0376e108680615c7f"
    }

    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: parameterEncoding)
        }

        return .requestPlain
    }

    var headers: [String : String]? {
        return [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }

    var baseURL : URL { return URL(string:  "https://api.themoviedb.org/3")! }
    var path: String {
        switch self {
        case .getMovies:
            return "/search/movie"
        case .getMovieDetails(let movieId):
            return "/movie/\(movieId)"
        }
        
    }

    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        case .getMovieDetails:
            return .get
        }
    }


    var parameters: [String: Any]? {
        switch self {
        case .getMovies(let query):
            return [
                "api_key": kAPIKey,
                "query": query
            ]
        case .getMovieDetails:
            return [
                "api_key": kAPIKey
            ]
        }
    }

    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .getMovies:
            return URLEncoding()
        case .getMovieDetails:
            return URLEncoding()
        }
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
}

// this function will be used in below closure
public func url(route: TargetType) -> String {
    let url = route.baseURL.appendingPathComponent(route.path).absoluteString
    return url
}
