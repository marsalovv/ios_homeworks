
import Foundation

struct Post {
    
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
    
    
    static func getPostsArray() -> [Post] {
[
            Post(author: "Dog", description: "Я злая собака!!!", image: "dog.jpg", likes: 298, views: 2380),
            Post(author: "Angoric", description: "У меня лапки!", image: "avatar.jpg", likes: 4230, views: 5149),
            Post(author: "Elephant", description: "Видали хобот?!", image: "elephant.jpg", likes: 351, views: 12649),
            Post(author: "Frog", description: "Поцелуй меня...", image: "frog.jpg", likes: 237, views: 589)
        ]
        
    }

}
