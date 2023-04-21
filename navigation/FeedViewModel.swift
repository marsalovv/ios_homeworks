

class FeedViewModel {
    
    private let model: FeedModel
    
    init(model: FeedModel) {
        self.model = model
    }
    
    func check(word: String) -> Bool{
        word == model.secretWord ? true : false
    }

}
