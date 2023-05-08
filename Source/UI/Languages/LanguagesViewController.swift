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

        dutchView.tag = ViewPressed.dutch.rawValue
        englishView.tag = ViewPressed.english.rawValue
        germanView.tag = ViewPressed.german.rawValue

        let font = UIFont(name: "Graphik-Regular", size: 14)
        dutchLabel.font = font
        englishLabel.font = font
        germanLabel.font = font

        let germanTap = UITapGestureRecognizer(target: self, action: #selector(viewSelected(gr:)))
        let englishTap = UITapGestureRecognizer(target: self, action: #selector(viewSelected(gr:)))
        let dutchTap = UITapGestureRecognizer(target: self, action: #selector(viewSelected(gr:)))

        germanView.addGestureRecognizer(germanTap)
        englishView.addGestureRecognizer(englishTap)
        dutchView.addGestureRecognizer(dutchTap)
    }

    @objc
    func viewSelected(gr: UITapGestureRecognizer) {
        guard let view = gr.view, let viewTag = ViewPressed(rawValue: view.tag) else {
            print("GetivySDK: Could not load language for view tag: %@", view.tag)
            return
        }

        switch viewTag {
        case ViewPressed.german:
            setLocale(code: Languages.german.rawValue)
            break
        case ViewPressed.english:
            setLocale(code: Languages.english.rawValue)
            break
        case ViewPressed.dutch:
            setLocale(code: Languages.dutch.rawValue)
            break
        }
        
        dismiss(animated: true)
    }
}
