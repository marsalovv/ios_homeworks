
import UIKit

class CurrentUserService: UserService {
    
    var user: User
    
    init() {
        self.user = User(login: "angoric", fullName: "Angoric", status: "У меня лапки", avatar: UIImage(named: "avatar.jpg")!)
    }
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }
    
    convenience init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.init(user: User(login: login, fullName: fullName, status: status, avatar: avatar))
    }
    
    func checkingCorrectnessOfLogin(login: String) -> User? {
        guard user.login == login else {return nil}
        return user
    }
}
