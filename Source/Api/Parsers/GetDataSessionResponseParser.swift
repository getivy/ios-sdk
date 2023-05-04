import Foundation

final class GetDataSessionResponseParser {
    func parse(data: Data) throws -> GetDataSessionResponse {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(GetDataSessionResponse.self, from: data)
        } catch {
            throw GetivySDKError.invalidGetSessionDetailsResponse
        }
    }
}
