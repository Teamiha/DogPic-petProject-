//
//  VideoViewController.swift
//  DogPic
//
//  Created by Михаил Светлов on 14.04.2022.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        loadRequest()
    }
    
    private func loadRequest() {
        guard let url = URL(string: "https://random.dog/0e8e840e-dfd0-4511-9003-6a608ecaeb8b.gif") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
 

}
