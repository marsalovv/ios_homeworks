
import Foundation
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject{
    func checkCredentials(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signUp(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
}
