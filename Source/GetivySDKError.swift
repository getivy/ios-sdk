import Foundation

public enum GetivySDKError: Error {
    case invalidURL
    case URLMissingIdParameter
    case couldNotDetermineSessionDetails
    case invalidGetSessionDetailsResponse
    case unexpectedGetDataSessionResponse
    case couldNotConstructFullUrlForEnvironment
    case sessionVerificationFailed
    case failedToEncodeGetDataSessionRequest
}
