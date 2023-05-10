import Foundation

enum WebViewApiRoute: ApiRoute { case

    load(dataSessionId: String, bankId: String, locale: String)

    var path: String {
        switch self {
        case let .load(dataSessionId, bankId, locale): return "init?id=\(dataSessionId)&bankId=\(bankId)&locale=\(locale)"
        }
    }
}
