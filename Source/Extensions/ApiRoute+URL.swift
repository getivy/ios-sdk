import Foundation

extension ApiRoute {
    func url(for environment: Environment) -> URL? {
        URL(string: "\(environment.url)/\(path)")
    }

    func paymentUrl(for environment: Environment) -> URL? {
        URL(string: "\(environment.paymentsUrl)/\(path)")
    }
}
