import Foundation

// By conforming to the ObservableObject protocol, it can start to broadcast >=1 properties to any
// interest parties -> makes NetworkManager "observable"
// Then, >=1 of its properties can be "published" to say that whenever it has changes to notify
// all of the listeners

class NetworkManager: ObservableObject{
    
    @Published var posts = [Post]()
    
    func fetchData() {
        
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
            
                if error == nil {                                       // if no errors
                    
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
