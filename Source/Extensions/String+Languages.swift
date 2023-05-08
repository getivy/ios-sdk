import Foundation

extension String {
    func localized(language: Languages = .english) -> String {
        guard
            let path = Bundle(for: LanguagesViewController.self).path(forResource: language.rawValue,
                                                                      ofType: "lproj"),
            let bundle = Bundle(path: path) else {
            return self
        }

        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
