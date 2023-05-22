import Foundation

enum WebMessageType: String, Decodable {
    case sdk
}

enum WebMessageSource: String, Decodable {
    case ivy
}

enum WebMessageOutcome: String, Decodable {
    case success
    case error
    case cancel
}

struct WebResult: Decodable {
    let dataId: String?
    let referenceId: String?
    let source: WebMessageSource
    let type: WebMessageType
    let value: WebMessageOutcome
}
