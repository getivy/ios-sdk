import Foundation

public enum GetivySDKError: Error {
    case invalidURL
    case URLMissingIdParameter
    case couldNotDetermineSessionDetails
    case invalidGetSessionDetailsResponse
    case invalidListBanksListResponse
    case invalidSearchBanksListResponse
    case couldNotConstructFullUrlForEnvironment
    case sessionVerificationFailed
    case failedToEncodeRequest
    case couldNotLoadViewFromStoryboard
    case webViewLoadedWithoutBankId
}

// 2. Return some errors prefixed with something to mean ios to client
