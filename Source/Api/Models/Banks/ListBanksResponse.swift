import Foundation

struct ListBanksResponse: Codable {
    let banks: [BankDetails]
}

struct BankDetails: Codable {
    let name: String
    let id: String
    let logo: String
    var group: String?
}
