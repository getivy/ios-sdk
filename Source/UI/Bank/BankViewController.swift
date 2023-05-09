import UIKit

class BankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var banks: [BankDetails] = []
    var filteredBanks: [BankDetails] = []
    var isSearching = false

    var router: PresentationUIHandler?
    var banksService: BanksApiService?
    var group: String?

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

        sendBanksRequest()
    }

    func sendBanksRequest() {
        banksService?.list(
            route: .list,
            params: ListBanksRequest(group: group),
            completion: { [weak self] result in
                switch result {
                case let .success(banks):
                    self?.banks = banks
                    self?.filteredBanks = banks
                    self?.tableView.reloadData()
                case let .failure(error):
                    print("GetivySDK: Error getting banks list: %@", error)
                }
            }
        )
    }

    func setupView() {
        let cornerRadius: CGFloat = 25
        let titleSize: CGFloat = 19
        let disclaimerSize: CGFloat = 10
        let searchSize: CGFloat = 14

        backButton.setTitle("", for: .normal)
        backButton.isHidden = group == nil
        languageButton.setTitle("", for: .normal)
        languageButton.imageView?.contentMode = .scaleAspectFit
        poweredByContainer.layer.cornerRadius = cornerRadius

        titleLabel.font = UIFont(name: "Graphik-Semibold", size: titleSize)
        disclaimerTextView.font = UIFont(name: "Inter-Regular", size: disclaimerSize)

        // Set search field font

        let searchFont = UIFont(name: "Graphik-Regular", size: searchSize)
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

    @IBAction func didPressBack(_ sender: UIButton) {
        router?.goBack()
    }

    @objc
    func languageChanged() {
        let language = Languages(rawValue: getLocale() ?? Languages.english.rawValue) ?? .english

        let bundle = Bundle(for: LanguagesViewController.self)

        switch language {
        case .dutch:
            languageButton.setImage(UIImage(named: "Nederlands", in: bundle, compatibleWith: nil), for: .normal)
        case .english:
            languageButton.setImage(UIImage(named: "English", in: bundle, compatibleWith: nil), for: .normal)
        case .german:
            languageButton.setImage(UIImage(named: "Germany", in: bundle, compatibleWith: nil), for: .normal)
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

        router.presentLanguagesView(over: sender)
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBanks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = filteredBanks[indexPath.row]
        let itemName = item.group ?? item.name
        cell.textLabel?.text = itemName
        let imageSize = 42
        let fontSizeForLetter: CGFloat = 20
        cell.imageView?.image = UIColor(hexString: "#BDBDBD")?
            .imageWithInitial(String(itemName.first ?? "B"),
                              size: CGSize(width: imageSize, height: imageSize),
                              textColor: .white,
                              font: UIFont(name: "Graphik-Regular", size: fontSizeForLetter) ?? UIFont())
        cell.imageView?.load(url: URL(string: item.logo))
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredBanks[indexPath.row]
        if item.group != nil {
            router?.presentBankView(animated: true, group: item.group)
        }
    }

    // MARK: - Search bar delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBanks = searchText.isEmpty ? banks : banks.filter { (item: BankDetails) -> Bool in
            // If the search text is empty, show all elements. Otherwise, filter based on the search text
            let value = item.group ?? item.name
            return value.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        isSearching = !searchText.isEmpty
        tableView.reloadData()
    }
}
