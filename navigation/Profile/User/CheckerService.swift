import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signUp(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
}


class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()
    
    func checkCredentials(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password , completion: completion)
    }
    
    func signUp(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
}
