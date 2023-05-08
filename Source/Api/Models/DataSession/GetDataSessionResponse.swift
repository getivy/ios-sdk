import Foundation

struct GetDataSessionResponse: Codable {
    let id: String
    let status: String
    var locale: String?
    let prefill: BankInformation
}

struct BankInformation: Codable {
    let bankId: String?
}
