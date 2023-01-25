import Foundation
import RealmSwift

class RealmManager {
    
    static let manager = RealmManager()
    
    init() {
        let config = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = config
    }
    func userSave() -> RealmUserModel? {
        let realm = try! Realm()
        for user in realm.objects(RealmUserModel.self) {
            return user
        }
        return nil
    }
    
    func login(email: String, password: String) -> RealmUserModel{
        let realm = try! Realm()
        let user = RealmUserModel(email: email, password: password)
        
        try! realm.write {
            realm.add(user)
        }
        return user
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
