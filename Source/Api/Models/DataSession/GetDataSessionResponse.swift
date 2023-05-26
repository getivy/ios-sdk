import Foundation

struct GetDataSessionResponse: Codable {
    let id: String
    var locale: String?
    let prefill: BankInformation
    let market: String
}

struct BankInformation: Codable {
    let bankId: String?
}
