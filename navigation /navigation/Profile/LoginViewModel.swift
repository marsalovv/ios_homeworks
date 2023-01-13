

import Foundation

protocol LoginViewModuleProtocol {
    var user: User? {get set}
}

class LoginViewModel: LoginViewModuleProtocol {
    
    var user: User?


    enum UserVerification {
        case usererror
        case passwordError
        case successfully
    }
    
    func check(email: String, password: String) -> UserVerification {
#if DEBUG
        let currentUser = TestUserService()
#else
        let currentUser = CurrentUserService()
#endif
        guard let verifiedUser = currentUser.checkingCorrectnessOfLogin(login: email) else { return .usererror }

        let factory = MyLoginFactory()
        let loginDelegate = factory.makeLoginInspector()
        guard loginDelegate.check(login: email, password: password) == true else { return .passwordError }
    
        user = verifiedUser
        return .successfully
    }
}
