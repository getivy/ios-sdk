import Foundation

enum DataSessionApiRoute: ApiRoute { case

    retrieve

    var path: String {
        switch self {
        case .retrieve: return "api/service/data/session/details"
        }
    }
}
