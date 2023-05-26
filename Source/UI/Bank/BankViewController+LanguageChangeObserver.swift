import Foundation

extension BankViewController: LanguageChangeObserver {
    func didChangeLanguage(code: String) {
        languageChanged()
    }
}
