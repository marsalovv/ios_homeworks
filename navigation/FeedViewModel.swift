

class FeedViewModel {
    
    static let shared = FeedViewModel()
    
    private let model = FeedModel()
    
    func check(word: String) -> Bool{
        word == model.secretWord ? true : false
    }

}
