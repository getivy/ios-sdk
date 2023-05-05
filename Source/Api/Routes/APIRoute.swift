import Foundation

protocol ApiRoute {
    var path: String { get }

    func url(for environment: Environment) -> URL?
}
