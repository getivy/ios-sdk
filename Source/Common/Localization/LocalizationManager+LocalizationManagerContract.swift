import Foundation

extension LocalizationManager: LocalizationManagerContract {
    func setLocale(code: String) {
        userDefaults.set(code, forKey: kLocaleKey)
        userDefaults.synchronize()

        notifyObserversLanguageChange(code: code)
    }

    func getLocaleCode() -> String {
        guard let locale = userDefaults.string(forKey: kLocaleKey) else {
            return Locale.current.languageCode ?? Languages.default().rawValue
        }

        return locale
    }

    func addObserver(observer: LanguageChangeObserver) {
        observers.append(observer)
    }

    func removeObserver(observer: LanguageChangeObserver) {
        observers.removeAll { $0 === observer }
    }
}
