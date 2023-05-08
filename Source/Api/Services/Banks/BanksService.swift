import Foundation

typealias ListBanksCompletion = (Result<[BankDetails], Error>) -> Void

protocol BanksService {
    func list(
        route: BanksApiRoute,
        params: ListBanksRequest,
        completion: @escaping ListBanksCompletion
    )
}
