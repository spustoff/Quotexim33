import SwiftUI
import FirebaseRemoteConfig
import WebKit

final class ViewWebModel: ObservableObject {
    
    @Published var link = URL(string: "")
    
    func getLink() {
        
        let config = RemoteConfig.remoteConfig()
        
        config.configSettings.minimumFetchInterval = 300
        config.fetchAndActivate{ _, _ in
            
            guard
                let url_string = config.configValue(forKey: "url_link").stringValue, let url = URL(string: url_string)
                
            else {
                
                return
            }
            
            self.link = url
        }
    }
}

struct WebView2: UIViewRepresentable {
    
    var link: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        guard let link = link else {
            
            return
        }
        
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
        webView.load(URLRequest(url: link))
    }
}
