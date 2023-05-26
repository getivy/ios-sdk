import Foundation

final class LocalizationManager {
    let userDefaults: UserDefaults

    let kLocaleKey = "kGetivySharedLocaleKey"

    var observers = [LanguageChangeObserver]()

    init(userDefaults: UserDefaults, initialLocale: String?) {
        self.userDefaults = userDefaults

        if let initialLocale {
            setLocale(code: initialLocale)
        }
    }

    func notifyObserversLanguageChange(code: String) {
        for observer in observers {
            observer.didChangeLanguage(code: code)
        }
    }
}
