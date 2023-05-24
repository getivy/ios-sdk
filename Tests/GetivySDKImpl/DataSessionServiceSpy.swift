import Foundation
@testable import GetivySDK

class DataSessionServiceSpy: ApiService, DataSessionService {
    var invokedRetrieveDataSession = false
    var invokedRetrieveDataSessionCount = 0
    var invokedRetrieveDataSessionParameters: (route: DataSessionApiRoute, params: GetDataSessionRequest)?
    var invokedRetrieveDataSessionParametersList = [(route: DataSessionApiRoute, params: GetDataSessionRequest)]()
    var stubbedRetrieveDataSessionCompletionResult: (Result<GetDataSessionResponse, Error>, Void)?

    func retrieveDataSession(
        route: DataSessionApiRoute,
        params: GetDataSessionRequest,
        completion: @escaping RetrieveDataSessionResponse
    ) {
        invokedRetrieveDataSession = true
        invokedRetrieveDataSessionCount += 1
        invokedRetrieveDataSessionParameters = (route, params)
        invokedRetrieveDataSessionParametersList.append((route, params))
        if let result = stubbedRetrieveDataSessionCompletionResult {
            completion(result.0)
        }
    }
}
