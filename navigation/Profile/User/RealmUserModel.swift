import Foundation
import RealmSwift


class RealmUserModel: Object {
    @Persisted var email: String
    @Persisted var password: String
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
