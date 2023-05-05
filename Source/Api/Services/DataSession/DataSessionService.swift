import Foundation

typealias RetrieveDataSessionResponse = (Result<GetDataSessionResponse, Error>) -> Void

protocol DataSessionService {
    func retrieveDataSession(
        route: ApiRoute,
        params: GetDataSessionRequest,
        completion: @escaping RetrieveDataSessionResponse
    )
}
