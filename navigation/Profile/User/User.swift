
import UIKit

class User {
    
var login: String
    var fullName: String
    var status: String
    var avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }

}
