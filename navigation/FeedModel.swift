
class FeedModel {
    
    static let shared = FeedModel()
    
    private let secretWord = "курица"
    
    func check(word: String) -> Bool{
        word == secretWord ? true : false
    }
}
