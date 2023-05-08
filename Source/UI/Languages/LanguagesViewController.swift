import UIKit

enum Languages: String { case
    english = "en",
    german = "de",
    dutch = "nl"
}

class LanguagesViewController: UIViewController {
    enum ViewPressed: Int { case
        german,
        dutch,
        english
    }

    @IBOutlet var dutchLabel: UILabel!
    @IBOutlet var englishLabel: UILabel!
    @IBOutlet var germanLabel: UILabel!

    @IBOutlet var dutchView: UIView!
    @IBOutlet var englishView: UIView!
    @IBOutlet var germanView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let languagesFontSize: CGFloat = 14

        dutchView.tag = ViewPressed.dutch.rawValue
        englishView.tag = ViewPressed.english.rawValue
        germanView.tag = ViewPressed.german.rawValue

        let font = UIFont(name: "Graphik-Regular", size: languagesFontSize)
        dutchLabel.font = font
        englishLabel.font = font
        germanLabel.font = font

        let germanTap = UITapGestureRecognizer(target: self, action: #selector(viewSelected(gestureRecognizer:)))
        let englishTap = UITapGestureRecognizer(target: self, action: #selector(viewSelected(gestureRecognizer:)))
        let dutchTap = UITapGestureRecognizer(target: self, action: #selector(viewSelected(gestureRecognizer:)))

        germanView.addGestureRecognizer(germanTap)
        englishView.addGestureRecognizer(englishTap)
        dutchView.addGestureRecognizer(dutchTap)
    }

    @objc
    func viewSelected(gestureRecognizer: UITapGestureRecognizer) {
        guard let view = gestureRecognizer.view, let viewTag = ViewPressed(rawValue: view.tag) else {
            print("GetivySDK: Could not load language for view tag: %@", view.tag)
            return
        }

        switch viewTag {
        case ViewPressed.german:
            setLocale(code: Languages.german.rawValue)
        case ViewPressed.english:
            setLocale(code: Languages.english.rawValue)
        case ViewPressed.dutch:
            setLocale(code: Languages.dutch.rawValue)
        }

        dismiss(animated: true)
    }
}
