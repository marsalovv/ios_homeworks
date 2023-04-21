
import LocalAuthentication

class LocalAuthorizationService {
    
    private let context = LAContext()
    private let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    
    private var error: NSError?
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        context.localizedCancelTitle = "Ввести логин/пароль"
        guard context.canEvaluatePolicy(policy, error: &error) else {
            print(error!.localizedDescription)
            return
        }
        
        context.evaluatePolicy(policy, localizedReason: "Для быстрого входа...") {reply, error  in
            if let error = error {
                print(error.localizedDescription)
            }
            authorizationFinished(reply)
        }
    }
}
