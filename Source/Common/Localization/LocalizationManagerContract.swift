import Foundation

protocol LocalizationManagerContract {
    func setLocale(code: String)

    func getLocaleCode() -> String

    func addObserver(observer: LanguageChangeObserver)

    func removeObserver(observer: LanguageChangeObserver)
}
