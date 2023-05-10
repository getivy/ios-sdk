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

    func parseSearchResponse(data: Data) throws -> SearchBanksResponse {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(SearchBanksResponse.self, from: data)
        } catch {
            print(error)
            throw GetivySDKError.invalidSearchBanksListResponse
        }
    }
}
