//
//  VideoViewController.swift
//  DogPic
//
//  Created by Михаил Светлов on 14.04.2022.
//

import UIKit
import WebKit
import Alamofire

class VideoViewController: UIViewController {

    let webView = WKWebView()
    
    var dogURL = "https://www.google.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData("https://random.dog/woof.json") { i in
            switch i {
            case .success(let rez):
                print(rez)
                guard let test = rez.url else { return }
                self.dogURL = test
                print("- - - - - - - - - - - -")
                print(self.dogURL)
                print("- - - - - - - - - - - -")
            case .failure(let error):
                print(error)
            }
        }
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadRequest()
        }
//        loadRequest()
    }
    
    private func loadRequest() {
        guard let url = URL(string: dogURL) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
 
    func fetchData(_ url: String, completion: @escaping(Result<Dog, AFError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Dog.self) { dataResponse in
                switch dataResponse.result {
                case .success(let rez):
                    completion(.success(rez))
                    print(rez)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    
}
