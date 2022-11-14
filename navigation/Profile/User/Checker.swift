
import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login = "angoric"
    private let password = "qwerty123"
    
    func check(login: String, password: String) -> Bool {
        if self.login == login && self.password == password {
            return true
        } else {
            return false
        }
    }
}
