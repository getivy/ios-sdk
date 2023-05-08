import Foundation

enum BanksApiRoute: ApiRoute { case

    list

    var path: String {
        switch self {
        case .list: return "api/service/banks/list"
        }
    }
}
