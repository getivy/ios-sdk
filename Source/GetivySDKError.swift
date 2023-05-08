import Foundation

public enum GetivySDKError: Error {
    case invalidURL
    case URLMissingIdParameter
    case couldNotDetermineSessionDetails
    case invalidGetSessionDetailsResponse
    case invalidListBanksListResponse
    case couldNotConstructFullUrlForEnvironment
    case sessionVerificationFailed
    case failedToEncodeRequest
    case couldNotLoadViewFromStoryboard
}
