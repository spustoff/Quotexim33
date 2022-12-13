//
//  WebViewer.swift
//  BinaryCent
//
//  Created by Вячеслав on 12/8/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var pair: String
    var interval: String
    
    func makeUIView(context: Context) -> WKWebView {
        
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        let htmlstring = """

        <div style="background-color:#13151D;">
            <div style="background-color:#13151D;" class="tradingview-widget-container">
              <div id="tradingview_22f32"></div>
              <div style="background-color:#13151D;" class="tradingview-widget-copyright"><a href="https://ru.tradingview.com/symbols/BTCUSDT/?exchange=BINANCE" rel="noopener" target="_blank"><span class="blue-text"></span></a></div>
              <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
              <script type="text/javascript">
              new TradingView.widget(
              {
                "autosize": true,
                "symbol": "FX_IDC:\(pair)",
                "interval": "\(interval)",
                "timezone": "Etc/UTC",
                "theme": "dark",
                "style": "3",
                "locale": "en",
                "toolbar_bg": "#13151D",
                "enable_publishing": false,
                "hide_top_toolbar": true,
                "studies": [
                       
                ],
                "save_image": false,
                "container_id": "tradingview_cf2c9"

            }
              );
              </script>
            </div>
        </div>
        """
        
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
        webView.loadHTMLString(htmlstring, baseURL: nil)
    }
}
