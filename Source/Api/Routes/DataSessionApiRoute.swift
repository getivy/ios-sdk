import Foundation

enum DataSessionApiRoute: ApiRoute { case

    retrieve

    var path: String {
        switch self {
        case .retrieve: return "api/service/data/session/details"
        }
    }

    func url(for environment: Environment) -> URL? {
        URL(string: "\(environment.url)/\(path)")
    }
}
