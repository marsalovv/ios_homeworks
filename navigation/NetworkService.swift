
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
                print("The Internet connection appears to be offline.")
                return
            }
            
            print(dictionary)
            print(response.allHeaderFields)
            print(response.statusCode)
            
        }
        
        task.resume()
    }
    
    static func requestTitleInfoVC(string: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            else { return }
            
                guard let id = dictionary["id"] as? Int,
                      let userId = dictionary["userId"] as? Int,
                      let title = dictionary["title"] as? String,
                      let completed = dictionary["completed"] as? Bool
                else { return }
                
                let titleModel = TitleModel(userId: userId, id: id, title: title, completed: completed)
                completion(titleModel.title)

                print("error")
            
        }
        task.resume()
    }
    
    static func requestPlanet(string: String, completion: @escaping (Planet) -> Void) {
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, _, _ in
            guard let data = data else { return }
            guard let planet = try? JSONDecoder().decode(Planet.self, from: data) else {return}
            
            completion(planet)
        }
        task.resume()
        
    }
    
}


