import Foundation

enum BanksApiRoute: ApiRoute { case

    list,
    search

    var path: String {
        switch self {
        case .list: return "api/service/banks/list"
        case .search: return "api/service/banks/search"
        }
    }
}
