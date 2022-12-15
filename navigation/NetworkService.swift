
import Foundation

struct NetworkService {
    
    enum AppConfiguration {
        case one(URL)
        case two(URL)
        case three(URL)
    }
    
    let appConfiguration: AppConfiguration
    
    static func request(appConfiguration: AppConfiguration) {

        var url = URL(string: "")
        
        switch appConfiguration {
        case .one(let one):
            url = one
        case .two(let two):
            url = two
        case .three(let three):
            url = three
        }
        
        guard let url = url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let response = response as? HTTPURLResponse
            else  {
                print(error?.localizedDescription) //The Internet connection appears to be offline.
                return
            }
            
            print(dictionary)
            print(response.allHeaderFields)
            print(response.statusCode)
            
        }
        
        task.resume()
    }
    
}


