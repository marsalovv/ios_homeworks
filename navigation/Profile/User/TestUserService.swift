

import UIKit

class TestUserService: UserService {
    
    var user: User
    
    init() {
        self.user = User(login: "test", fullName: "Test login", status: "Тестовая конфигурация", avatar: UIImage(named: "dog")!)
    }
    
    func checkingCorrectnessOfLogin(login: String) -> User? {
        return user
    }
}

