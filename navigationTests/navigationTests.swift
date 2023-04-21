
import XCTest

final class FeedViewModelTests: XCTestCase {
    
    var feedViewModel: FeedViewModel!
    
    override func setUpWithError() throws {
        try         super.setUpWithError()
        feedViewModel = FeedViewModel(model: FeedModel(secretWord: "test"))
    }
    
    override func tearDownWithError() throws {
        feedViewModel = nil
        try super.tearDownWithError()
    }
    
    func testCheckWithRightWord() throws {
        let word = "test"
        
        let result = feedViewModel.check(word: word)
        
        XCTAssert(result, "Тест с правильным словом")
    }
    
    func testCheckWithEmptyLine() {
        let word = ""
        
        let result = feedViewModel.check(word: word)
        
        XCTAssertFalse(result, "Тест с пустой строкой")
    }
    
    func testCheckingWithWrongWord() {
        let word = "нога"
        
        let result = feedViewModel.check(word: word)
        
        XCTAssertFalse(result, "Тест с неправильным словом")
    }
    
}

