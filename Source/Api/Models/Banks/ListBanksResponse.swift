import Foundation

struct ListBanksResponse: Decodable {
    let banks: [BankDetails]
}

struct BankDetails: Decodable {
    let name: String
    let id: String
    let logo: String?
    var group: String?
}
