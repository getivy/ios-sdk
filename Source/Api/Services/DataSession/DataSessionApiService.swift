import Foundation

final class DataSessionApiService: ApiService, DataSessionService {
    let parser: DataSessionResponseParser

    init(
        context: ApiContext,
        session: URLSession,
        parser: DataSessionResponseParser
    ) {
        self.parser = parser

        super.init(context: context, session: session)
    }

    func retrieveDataSession(
        route: DataSessionApiRoute,
        params: GetDataSessionRequest,
        completion: @escaping RetrieveDataSessionResponse
    ) {
        post(
            route: route,
            parameters: params
        ) { data, _, _ in
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(GetivySDKError.serverResponseWithNoData))
                }
                return
            }

            do {
                let decodedResponse = try self.parser.parseDataSessionDetails(data: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
