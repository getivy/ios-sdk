import Foundation

final class BanksApiService: ApiService, BanksService {
    let parser: BanksResponseParser

    init(
        context: ApiContext,
        session: URLSession,
        parser: BanksResponseParser
    ) {
        self.parser = parser

        super.init(context: context, session: session)
    }

    func list(
        route: BanksApiRoute,
        params: ListBanksRequest,
        completion: @escaping ListBanksCompletion
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
                let decodedResponse = try self.parser.parseListResponse(data: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse.banks))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func search(
        route: BanksApiRoute,
        params: SearchBanksRequest,
        completion: @escaping SearchBanksCompletion
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
                let decodedResponse = try self.parser.parseSearchResponse(data: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse.banks))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
