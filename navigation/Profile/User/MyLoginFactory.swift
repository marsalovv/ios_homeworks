
struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        return loginInspector
    }
    
}

