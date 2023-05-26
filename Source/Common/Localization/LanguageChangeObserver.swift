import Foundation

protocol LanguageChangeObserver: AnyObject {
    func didChangeLanguage(code: String)
}
