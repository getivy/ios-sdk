import Foundation

extension WebViewController: LanguageChangeObserver {
    func didChangeLanguage(code: String) {
        let language = Languages(rawValue: code) ?? Languages.default()
        let closeTitle = "cancel".localized(language: language)
        closeButton.setTitle(closeTitle, for: .normal)
    }
}
