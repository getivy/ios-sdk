import Foundation

public enum GetivySDKError: Error {
    case invalidListBanksListResponse
    case invalidSearchBanksListResponse
    case serverResponseWithNoData
    case invalidURL
    case invalidGetSessionDetailsResponse
    case couldNotConstructFullUrlForEnvironment
    case failedToEncodeRequest
    case couldNotLoadViewFromStoryboard
    case flowNotSuccessful
    case featureWantedExternalBrowser
}
