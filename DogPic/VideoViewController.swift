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
    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var webView: WKWebView!
    //let webView = WKWebView()
    
    var dogURL = "https://www.google.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData("https://random.dog/woof.json") { i in
            switch i {
            case .success(let dogPicAdress):
                print("- - - - - - - - - - -")
                print(dogPicAdress)
                print("- - - - - - - - - - -")

                guard let dogPic = dogPicAdress.url else { return }
                self.dogURL = dogPic
            case .failure(let error):
                print(error)
            }
        }
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isOpaque = false;
        webView.backgroundColor = UIColor.white
        
        webView.addObserver(self, forKeyPath:
                        #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "estimatedProgress" {
               progressBar.progress = Float(webView.estimatedProgress)
               let progress = progressBar.progress
               if progress == 1.0 {
                   progressBar.isHidden = true
               }
           }
       }

    
    

    
    
    
    
    @IBAction func reload(_ sender: Any) {
        fetchData("https://random.dog/woof.json") { i in
            switch i {
            case .success(let rez):
                self.progressBar.isHidden = false
                guard let test = rez.url else { return }
                self.dogURL = test
            case .failure(let error):
                print(error)
            }
        }
    }

    
    private func loadRequest() {
        guard let url = URL(string: dogURL) else { return }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        lazy var test = webView.estimatedProgress
        print(test)
    }
 
    func fetchData(_ url: String, completion: @escaping(Result<Dog, AFError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Dog.self) { dataResponse in
                switch dataResponse.result {
                case .success(let rez):
                    completion(.success(rez))
                    self.loadRequest()
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    
}
