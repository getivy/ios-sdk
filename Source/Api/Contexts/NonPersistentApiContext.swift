import Foundation

class NonPersistentApiContext: ApiContext {
    var environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }
}
