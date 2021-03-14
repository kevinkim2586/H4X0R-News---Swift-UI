import SwiftUI

// Adding @ObservedObject property sets up a
// property as a listener -> This way, we are subscribing
// to the updates from the NetworkManager

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    
    var body: some View {
        
        NavigationView {
            
            List(networkManager.posts) { post in
                HStack {
                    Text(String(post.points))
                    Text(post.title)
                }
            }
            .navigationTitle("H4X0R News")
            
        }
        .onAppear(perform: {
            networkManager.fetchData()
        })
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
