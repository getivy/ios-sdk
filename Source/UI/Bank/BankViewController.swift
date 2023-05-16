import UIKit

class BankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var banks: [BankDetails] = []
    var filteredBanks: [BankDetails] = []

    var router: PresentationUIHandler!
    var banksService: BanksApiService!
    var group: String?

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var noResultsSubtitle: UILabel!
    @IBOutlet var noResultsTitle: UILabel!
    @IBOutlet var noResultsContainerView: UIView!
    @IBOutlet var backButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet var disclaimerTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var poweredByContainer: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var languageButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        router.closeButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: languageChangedNotification, object: nil)

        setupView()

        languageChanged()

        if group != nil {
            sendBanksRequest()
        } else {
            sendSearchRequest()
        }
    }

    func sendSearchRequest() {
        let searchQuery = searchBar.text ?? ""
        let market = searchQuery.isEmpty ? router.market : nil

        banksService?.search(
            route: .search,
            params: SearchBanksRequest(search: searchQuery, market: market),
            completion: { [weak self] result in
                switch result {
                case let .success(banks):
                    self?.banks = banks
                    self?.filteredBanks = banks
                    self?.reloadData()
                case let .failure(error):
                    print("GetivySDK: Error getting banks search: ", error)
                    self?.validate(error: error)
                }
            }
        )
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
                    self?.reloadData()
                case let .failure(error):
                    print("GetivySDK: Error getting banks list: ", error)
                    self?.validate(error: error)
                }
            }
        )
    }

    func validate(error: Error) {
        if let hardError = error as? GetivySDKNonRecoverableError {
            DispatchQueue.main.async { [weak self] in
                self?.router.closeWithNonRecoverable(error: error)
            }
        }
    }

    func setupView() {
        let cornerRadius: CGFloat = 25
        let titleSize: CGFloat = 19
        let disclaimerSize: CGFloat = 10
        let searchSize: CGFloat = 14

        let semiBold = UIFont(name: "Graphik-Semibold", size: titleSize)
        let regular = UIFont(name: "Graphik-Regular", size: searchSize)

        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.setTitle("", for: .normal)

        noResultsTitle.textColor = UIColor(hexString: "#252525")
        noResultsTitle.font = semiBold
        noResultsSubtitle.textColor = UIColor(hexString: "#717171")
        noResultsSubtitle.font = regular

        backButton.setTitle("", for: .normal)
        if group == nil {
            backButton.isHidden = true
            backButtonWidthConstraint.constant = 0
        }
        languageButton.setTitle("", for: .normal)
        languageButton.imageView?.contentMode = .scaleAspectFit
        poweredByContainer.layer.cornerRadius = cornerRadius

        titleLabel.font = semiBold
        disclaimerTextView.font = UIFont(name: "Inter-Regular", size: disclaimerSize)

        // Set search field font

        for subView in searchBar.subviews {
            if let searchField = subView as? UITextField {
                searchField.font = regular
                break
            }
        }

        // Setup table
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction
    func didPressBack(_ sender: UIButton) {
        router.goBack()
    }

    @IBAction func didPressCloseButton(_ sender: UIButton) {
        router.closeWithNonRecoverable(error: GetivySDKNonRecoverableError.flowNotSuccessful)
    }

    @objc
    func languageChanged() {
        let language = Languages(rawValue: getLocale() ?? Languages.english.rawValue) ?? .english

        let bundle = Bundle(for: LanguagesViewController.self)

        let disclaimerString = "bankDisclaimer".localized(language: language)
        let mutableString = NSMutableAttributedString(string: disclaimerString)

        switch language {
        case .dutch:
            mutableString.setAsUnderlinedLink(textToFind: " Ivy", linkURL: "https://getivy.io")
            mutableString.setAsUnderlinedLink(textToFind: "AV van", linkURL: "https://getivy.io/agbs")
            mutableString.setAsUnderlinedLink(textToFind: "Privacybeleid", linkURL: "https://getivy.io/datenschutz")
            mutableString.setAsUnderlinedLink(textToFind: "Cookiebeleid", linkURL: "https://getivy.io/datenschutz")
            languageButton.setImage(UIImage(named: "Nederlands", in: bundle, compatibleWith: nil), for: .normal)
        case .english:
            mutableString.setAsUnderlinedLink(textToFind: "Ivy's ", linkURL: "https://getivy.io")
            mutableString.setAsUnderlinedLink(textToFind: "Terms", linkURL: "https://getivy.io/agbs")
            mutableString.setAsUnderlinedLink(textToFind: "Privacy Policy", linkURL: "https://getivy.io/datenschutz")
            mutableString.setAsUnderlinedLink(textToFind: "Cookie Policy", linkURL: "https://getivy.io/datenschutz")
            languageButton.setImage(UIImage(named: "English", in: bundle, compatibleWith: nil), for: .normal)
        case .german:
            mutableString.setAsUnderlinedLink(textToFind: "Ivy's ", linkURL: "https://getivy.io")
            mutableString.setAsUnderlinedLink(textToFind: "AGBs", linkURL: "https://getivy.io/agbs")
            mutableString.setAsUnderlinedLink(textToFind: "Datenschutzbestimmung", linkURL: "https://getivy.io/datenschutz")
            mutableString.setAsUnderlinedLink(textToFind: "Cookie-Richtlinie", linkURL: "https://getivy.io/datenschutz")
            languageButton.setImage(UIImage(named: "Germany", in: bundle, compatibleWith: nil), for: .normal)
        }

        titleLabel.text = "bankTitle".localized(language: language)
        disclaimerTextView.attributedText = mutableString

        searchBar.placeholder = "bankSearchSuggestion".localized(language: language)

        noResultsTitle.text = "noBanksFoundTitle".localized(language: language)
        noResultsSubtitle.text = "noBanksFoundMessage".localized(language: language)
    }

    @IBAction
    func didPressLanguageButton(_ sender: UIButton) {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BankTableViewCell", for: indexPath) as? BankTableViewCell else {
            return UITableViewCell()
        }
        let item = filteredBanks[indexPath.row]
        cell.setup(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = filteredBanks[indexPath.row]
        if group == nil && item.group != nil {
            router?.presentBankView(animated: true, group: item.group)
        } else {
            router?.presentWebView(bankId: item.id, animated: true)
        }
    }

    // MARK: - Search bar delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if group != nil {
            filteredBanks = searchText.isEmpty ? banks : banks.filter { (item: BankDetails) -> Bool in
                // If the search text is empty, show all elements. Otherwise, filter based on the search text
                let value = item.group ?? item.name
                return value.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }

            reloadData()
        } else {
            sendSearchRequest()
        }
    }

    func reloadData() {
        tableView.reloadData()
        noResultsContainerView.isHidden = !filteredBanks.isEmpty
    }
}
