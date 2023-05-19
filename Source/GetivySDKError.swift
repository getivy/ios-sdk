import Foundation

public enum GetivySDKRecoverableError: Error {
    case invalidListBanksListResponse
    case invalidSearchBanksListResponse
    case serverResponseWithNoData
}

public enum GetivySDKNonRecoverableError: Error {
    case invalidURL
    case invalidGetSessionDetailsResponse
    case couldNotConstructFullUrlForEnvironment
    case failedToEncodeRequest
    case couldNotLoadViewFromStoryboard
    case flowNotSuccessful
    case featureWantedExternalBrowser
}
