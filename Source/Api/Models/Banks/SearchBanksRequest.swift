struct SearchBanksRequest: Encodable {
    var search: String?
    let market: String
    let capability = "ais"
}
