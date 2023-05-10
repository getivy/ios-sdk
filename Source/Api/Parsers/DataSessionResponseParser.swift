import Foundation

final class DataSessionResponseParser {
    func parseDataSessionDetails(data: Data) throws -> GetDataSessionResponse {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(GetDataSessionResponse.self, from: data)
        } catch {
            throw GetivySDKError.invalidGetSessionDetailsResponse
        }
    }
}
