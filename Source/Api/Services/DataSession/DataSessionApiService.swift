import Foundation

final class DataSessionApiService: ApiService, DataSessionService {
    let parser: GetDataSessionResponseParser

    init(
        context: ApiContext,
        session: URLSession,
        parser: GetDataSessionResponseParser
    ) {
        self.parser = parser

        super.init(context: context, session: session)
    }

    func retrieveDataSession(
        route: ApiRoute,
        params: GetDataSessionRequest,
        completion: @escaping RetrieveDataSessionResponse
    ) {
        post(
            route: route,
            parameters: params
        ) { data, _, _ in
            guard let data else {
                completion(.failure(GetivySDKError.sessionVerificationFailed))
                return
            }

            do {
                let decodedResponse = try self.parser.parse(data: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
