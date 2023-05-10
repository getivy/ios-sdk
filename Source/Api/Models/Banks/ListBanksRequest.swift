import Foundation

struct ListBanksRequest: Encodable {
    var group: String?
    let capability = "ais"
}
