import Foundation

final class BanksResponseParser {
    func parseListResponse(data: Data) throws -> ListBanksResponse {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ListBanksResponse.self, from: data)
        } catch {
            throw GetivySDKError.invalidListBanksListResponse
        }
    }
}
