import Foundation
import RealmSwift

class RealmManager {
    
    static let manager = RealmManager()
    
    init() {
        var config = Realm.Configuration(schemaVersion: 2)
        config.encryptionKey = getKey()
        
        do{
            let _ = try Realm(configuration: config)
        }catch{
            try? FileManager.default.removeItem(at: config.fileURL!)
        }
        
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
    
    private func getKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            // swiftlint:disable:next force_cast
            return dataTypeRef as! Data
        }
        
        // No pre-existing key from this application, so generate a new one
        // Generate a random encryption key
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
        
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return key
    }
    
    
}
