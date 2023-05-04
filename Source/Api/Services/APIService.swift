import Foundation

enum HTTPMethod: String {
    case POST
}

typealias PostResult = (Data?, URLResponse?, Error?) -> Void

class ApiService {
    let session: URLSession
    let context: ApiContext

    private var task: URLSessionTask?

    init(
        context: ApiContext,
        session: URLSession
    ) {
        self.session = session
        self.context = context
    }

    func post(
        route: ApiRoute,
        parameters: some Encodable,
        completion: @escaping PostResult
    ) {
        guard let url = route.url(for: context.environment) else {
            completion(nil, nil, GetivySDKError.couldNotConstructFullUrlForEnvironment)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            completion(nil, nil, error)
            return
        }
        task?.cancel()
        task = session.dataTask(with: request, completionHandler: completion)
        task?.resume()
    }
}
