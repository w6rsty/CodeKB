//
// TableScreen.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/2.
//

import SwiftUI
import WebKit
import UIKit

struct TableScreen : View {
    @State private var webView = WKWebView()
    // Sheet
    @State private var shouldShowWebView: Bool = false
    // 缩略图
    @State private var shouldShowThumbnail: Bool = false
    // 学号
    @AppStorage(.userID) private var userID: String = ""
    // 拼接后的完整URL
    @State private var url: String = ""
    // 获取的html字符串
    @State private var htmlContent: String = ""
    // WebView当前页面的URL
    @State private var currentURL: String = ""
    // 页面是否加载完成
    @State private var isFinished: Bool = false
    
    @State var schedule: Schedule?
    
    @State var week: [Week]?
    
    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                ScheduleView(numberOfWeeks: 20, weeks: week ?? Array(repeating: Week.empty(), count: 20))
                    .padding(5)
                
                if _shouldShowThumbnail.wrappedValue {
                    thumnailView
                }
            }
            .background(Color.clear)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("Today").font(.title)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    openSheetButton
                    openThumbnail
                }
            }
            .sheet(isPresented: $shouldShowWebView) {
                webViewSheet
            }
        }
        
    }
}


// Debug Extension
extension TableScreen {
    
    /// Debug 打印获取的html
    var debugDisplayButton: some View {
        Button("Print HTML") {
            
            if htmlContent.isEmpty {
                print("Empty html")
            } else {
                print(htmlContent)
            }
        }
        .animation(.easeIn, value: isFinished)
    }
}

extension TableScreen {
    /// 开启WebView的按钮
    var openSheetButton: some View {
        Button {
            url = "http://jwxt.cumt.edu.cn/jwglxt/kbcx/xskbcx_cxXskbcxIndex.html?gnmkdm=N253508&layout=default&su=\(userID)"
            shouldShowWebView.toggle()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    ///  开启缩略图按钮
    var openThumbnail: some View {
        Button {
            withAnimation {
                shouldShowThumbnail.toggle()
            }
        } label: {
            Image(systemName: "square.rightthird.inset.filled")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    
    var thumnailView: some View {
        Rectangle()
            .fill(gradient)
            .frame(width: 50)
            .transition(.move(edge: .trailing))
    }
    
    /// 构建Sheet的关闭按钮
    @ViewBuilder
    func buildCloseSheetButton(_ value: Binding<Bool>) -> some View {
        Button {
            value.wrappedValue = false
        } label: {
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(.red)
        }
        .padding()
    }
    
    /// WebView Sheet
    var webViewSheet: some View {
        VStack {
            sheetHeaderBar
            
            NavigationView {
                let webView = WebView(
                    url: $url,
                    webView: $webView,
                    isFinished: $isFinished,
                    currentURL: $currentURL
                )
                // View
                ZStack {
                    webView
                    VStack {
                        Spacer()
                        buildSaveButton(webView)
                    }
                }
            }
        }
    }
    
    /// 网址和关闭按钮
    var sheetHeaderBar: some View {
        HStack {
            Text(currentURL)
                .lineLimit(1)
                .padding(.horizontal)
            Spacer()
            buildCloseSheetButton($shouldShowWebView)
        }
        .padding(.bottom, -5)
    }
    
    /// 构建保存按钮
    @ViewBuilder
    func buildSaveButton(_ webView: WebView) -> some View {
        Button {
            // 在WebView保存页面html
            webView.getHtml { html in
                htmlContent = html
                shouldShowWebView = false
                
                assert(!html.isEmpty, "after save html: empty html")
                // 向后端发送html
                sendHtml(htmlString: html) { result in
                    assert(!html.isEmpty, "sending html: empty html")
                    switch result {
                    case .success(let data):
                        do {
                            schedule = try JSONDecoder().decode(Schedule.self, from: data)
                            print("Got data")
                            if let schedule = schedule {
                                week = schedule.toWeeks()
                            }
                        } catch {
                            print("Failed to decode JSON file\(error)")
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } label: {
            Text("提取课表")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .font(.title2)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
        .padding()
        .disabled(!currentURL.contains("http://jwxt.cumt.edu.cn/jwglxt/kbcx/xskbcx_cxXskbcxIndex.html?gnmkdm=N253508&layout=default&su="))
    }
    
    func sendHtml(htmlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://127.0.0.1:5000/endpoint")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("text/html", forHTTPHeaderField: "Content-Type")
        request.setValue("200", forHTTPHeaderField: "status")
        assert(!htmlString.isEmpty, "packing html request: empty html")
        request.httpBody = htmlString.data(using: .utf8)
        
        let session = URLSession(configuration: .default).dataTask(with: request) { data, response, error in
        
            if let error = error {
                completion(.failure(error))
                
            }
            if let data = data {
                completion(.success(data))
            }
        }
        session.resume()
    }
}


struct TableScreen_Previews: PreviewProvider {
    static var previews: some View {
        TableScreen()
    }
}

