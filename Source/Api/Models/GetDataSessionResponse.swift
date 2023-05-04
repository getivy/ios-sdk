import Foundation

struct GetDataSessionResponse: Codable {
    let id: String
    let status: String
    let prefill: BankInformation
}

struct BankInformation: Codable {
    let bankId: String?
}
