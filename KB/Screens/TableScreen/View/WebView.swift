//
//  WebView.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/2.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    // 要加载的URL
    @Binding var url: String
    @Binding var webView: WKWebView
    // 页面是否加载完成
    @Binding var isFinished: Bool
    // 当前页面的URL
    @Binding var currentURL: String
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let _url = URL(string: url) {
            let request = URLRequest(url: _url)
            webView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func getHtml(completion: @escaping (String) -> Void) {
        let script = "document.documentElement.outerHTML"
        webView.evaluateJavaScript(script) { result, error in
            if let html = result as? String {
                DispatchQueue.main.async {
                    completion(html)
                }
                isFinished = true
            } else if let e = error {
                // TODO: Handle error
                print("[Save Error]: \(e)")
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            // 页面开始加载
//            print("Loading")
//        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 页面加载完成
            // print("Finished")
            if let url = webView.url {
                self.parent.currentURL = url.absoluteString
            }
        }
    }
}
