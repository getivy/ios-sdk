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
        resultQueue: DispatchQueue = .main,
        completion: @escaping RetrieveDataSessionResponse
    ) {
        post(
            route: route,
            parameters: params
        ) { data, _, _ in
            guard let data else {
                resultQueue.async {
                    completion(.failure(GetivySDKError.sessionVerificationFailed))
                }
                return
            }

            do {
                let decodedResponse = try self.parser.parse(data: data)
                resultQueue.async {
                    completion(.success(decodedResponse))
                }
                
            } catch {
                resultQueue.async {
                    completion(.failure(error))
                }
                
            }
        }
    }
}
