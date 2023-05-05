import Foundation

typealias RetrieveDataSessionResponse = (Result<GetDataSessionResponse, Error>) -> Void

protocol DataSessionService {
    func retrieveDataSession(
        route: ApiRoute,
        params: GetDataSessionRequest,
        resultQueue: DispatchQueue,
        completion: @escaping RetrieveDataSessionResponse
    )
}
