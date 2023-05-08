import UIKit

func presentPopover(
    _ parentViewController: UIViewController,
    _ viewController: UIViewController,
    sender: UIView,
    arrowDirection: UIPopoverArrowDirection = .down
) {
    viewController.preferredContentSize = CGSize(width: 155, height: 123)
    viewController.modalPresentationStyle = .popover
    if let pres = viewController.presentationController {
        pres.delegate = parentViewController
    }
    parentViewController.present(viewController, animated: true)
    if let pop = viewController.popoverPresentationController {
        pop.sourceView = sender
        pop.sourceRect = sender.bounds
        pop.permittedArrowDirections = arrowDirection
    }
}

let kLocaleKey = "kGetivySharedLocaleKey"
let languageChangedNotification = Notification.Name("kGetivyLanguageChanged")

func setLocale(code: String) {
    UserDefaults.standard.set(code, forKey: kLocaleKey)
    UserDefaults.standard.synchronize()
    
    NotificationCenter.default.post(name: languageChangedNotification, object: nil)
}

func getLocale() -> String? {
    guard let locale = UserDefaults.standard.string(forKey: kLocaleKey) else {
        return nil
    }

    return locale
}
