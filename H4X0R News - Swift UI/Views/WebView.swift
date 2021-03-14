import Foundation
import WebKit
import SwiftUI

// The below protocol allows us to create a SwiftUIView
// that represents a UIKitView

struct WebView: UIViewRepresentable, View {
    
    typealias UIViewType = WKWebView
    
    let urlString: String?
    
    func makeUIView(context: Context) -> UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        if let safeString = urlString {
            
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
                
            }
        }
    }
}
