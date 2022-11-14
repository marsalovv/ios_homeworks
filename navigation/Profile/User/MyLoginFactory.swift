
struct MyLoginFactory: LoginFactory {
    
    static func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
}



let a = MyLoginFactory.makeLoginInspector()
