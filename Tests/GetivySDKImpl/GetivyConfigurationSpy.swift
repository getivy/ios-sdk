import Foundation
@testable import GetivySDK

class GetivyConfigurationSpy: GetivyConfiguration {
    var invokedOnSuccessSetter = false
    var invokedOnSuccessSetterCount = 0
    var invokedOnSuccess: SuccessCallback?
    var invokedOnSuccessList = [SuccessCallback]()
    var invokedOnSuccessGetter = false
    var invokedOnSuccessGetterCount = 0
    var stubbedOnSuccess: SuccessCallback!

    override var onSuccess: SuccessCallback {
        set {
            invokedOnSuccessSetter = true
            invokedOnSuccessSetterCount += 1
            invokedOnSuccess = newValue
            invokedOnSuccessList.append(newValue)
        }
        get {
            invokedOnSuccessGetter = true
            invokedOnSuccessGetterCount += 1
            return stubbedOnSuccess
        }
    }

    var invokedOnErrorSetter = false
    var invokedOnErrorSetterCount = 0
    var invokedOnError: ErrorCallback?
    var invokedOnErrorList = [ErrorCallback]()
    var invokedOnErrorGetter = false
    var invokedOnErrorGetterCount = 0
    var stubbedOnError: ErrorCallback!

    override var onError: ErrorCallback {
        set {
            invokedOnErrorSetter = true
            invokedOnErrorSetterCount += 1
            invokedOnError = newValue
            invokedOnErrorList.append(newValue)
        }
        get {
            invokedOnErrorGetter = true
            invokedOnErrorGetterCount += 1
            return stubbedOnError
        }
    }

    var invokedValidate = false
    var invokedValidateCount = 0
    var stubbedValidateResult: SDKErrorImpl!

    override func validate() -> SDKErrorImpl? {
        invokedValidate = true
        invokedValidateCount += 1
        return stubbedValidateResult
    }
}
