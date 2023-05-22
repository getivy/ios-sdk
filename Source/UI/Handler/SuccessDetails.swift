class SuccessDetails: Details {
    var referenceId: String?

    var dataSessionId: String?

    init(referenceId: String?, dataSessionId: String?) {
        self.referenceId = referenceId
        self.dataSessionId = dataSessionId
    }
}
