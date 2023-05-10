import Foundation

typealias RetrieveDataSessionResponse = (Result<GetDataSessionResponse, Error>) -> Void

protocol DataSessionService {
    func retrieveDataSession(
        route: DataSessionApiRoute,
        params: GetDataSessionRequest,
        completion: @escaping RetrieveDataSessionResponse
    )
}
