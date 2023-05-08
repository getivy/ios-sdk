import UIKit

class BankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    let elements = ["Apple", "Banana", "Cherry", "Dragonfruit", "Elderberry", "Fig", "Grape", "Honeydew"]
    var filteredElements = [String]()
    var isSearching = false

    var router: PresentationUIHandler?

    @IBOutlet var disclaimerTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var poweredByContainer: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var languageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: languageChangedNotification, object: nil)
        
        languageChanged()

        setupView()

        // Set the filtered elements to be the same as the original elements
        filteredElements = elements
    }
    
    func setupView() {
        backButton.setTitle("", for: .normal)
        languageButton.setTitle("", for: .normal)
        languageButton.imageView?.contentMode = .scaleAspectFit
        poweredByContainer.layer.cornerRadius = 25

        
        titleLabel.font = UIFont(name: "Graphik-Semibold", size: 19)
        disclaimerTextView.font = UIFont(name: "Inter-Regular", size: 10)
    
        // Set search field font
        
        let searchFont = UIFont(name: "GraphikRegular", size: 14)
        for subView in searchBar.subviews {
            if let searchField = subView as? UITextField {
                searchField.font = searchFont
                break
            }
        }

        // Setup table
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc
    func languageChanged() {
        let language = Languages(rawValue: getLocale() ?? Languages.english.rawValue) ?? .english
        
        let bundle = Bundle(for: LanguagesViewController.self)
        
        switch language {
        case .dutch:
            languageButton.setImage(UIImage(named: "Nederlands", in: bundle, compatibleWith: nil ), for: .normal)
        case .english:
            languageButton.setImage(UIImage(named: "English", in: bundle, compatibleWith: nil  ), for: .normal)
        case .german:
            languageButton.setImage(UIImage(named: "Germany", in: bundle, compatibleWith: nil  ), for: .normal)
        }
        
        titleLabel.text = "bankTitle".localized(language: language)
        
        let disclaimerString = "bankDisclaimer".localized(language: language)
        let mutableString = NSMutableAttributedString(string: disclaimerString)
        mutableString.setAsUnderlinedLink(textToFind: "Ivy's ", linkURL: "https://getivy.io")
        mutableString.setAsUnderlinedLink(textToFind: "AGBs", linkURL: "https://getivy.io/agbs")
        mutableString.setAsUnderlinedLink(textToFind: "Datenschutzbestimmung", linkURL: "https://getivy.io/datenschutz")
        mutableString.setAsUnderlinedLink(textToFind: "Cookie-Richtlinie", linkURL: "https://getivy.io/datenschutz")
        disclaimerTextView.attributedText = mutableString
        
        searchBar.placeholder = "bankSearchSuggestion".localized(language: language)
    }

    @IBAction func didPressLanguageButton(_ sender: UIButton) {
        guard let router else {
            print("GetivySDK: Router not found in banks screen")
            return
        }
        presentPopover(self, router.buildLanguages(), sender: sender)
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredElements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredElements[indexPath.row]
        return cell
    }

    // MARK: - Search bar delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredElements = searchText.isEmpty ? elements : elements.filter { (item: String) -> Bool in
            // If the search text is empty, show all elements. Otherwise, filter based on the search text
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        isSearching = !searchText.isEmpty
        tableView.reloadData()
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
