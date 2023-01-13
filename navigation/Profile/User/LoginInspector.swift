
import Foundation
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {
        
    func check(login: String, password: String) -> Bool {
        return true
    }
    
    func checkCredentials(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        CheckerService.shared.checkCredentials(email: email, password: password, completion: completion)
    }
    
    func signUp(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        CheckerService.shared.signUp(email: email, password: password, completion: completion)
    }
    
}

