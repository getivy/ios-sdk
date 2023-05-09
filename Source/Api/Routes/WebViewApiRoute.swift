import Foundation

enum WebViewApiRoute: ApiRoute { case

    load(dataSessionId: String, bankId: String)

    var path: String {
        switch self {
        case let .load(dataSessionId, bankId): return "init?id=\(dataSessionId)&bankId=\(bankId)"
        }
    }
}
