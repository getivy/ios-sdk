import Foundation

typealias ListBanksCompletion = (Result<[BankDetails], Error>) -> Void
typealias SearchBanksCompletion = (Result<[BankDetails], Error>) -> Void

protocol BanksService {
    func list(
        route: BanksApiRoute,
        params: ListBanksRequest,
        completion: @escaping ListBanksCompletion
    )

    func search(
        route: BanksApiRoute,
        params: SearchBanksRequest,
        completion: @escaping SearchBanksCompletion
    )
}
