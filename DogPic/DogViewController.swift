//
//  DogViewController.swift
//  DogPic
//
//  Created by Михаил Светлов on 12.04.2022.
//

import UIKit

class DogViewController: UIViewController {
    @IBOutlet var activity: UIActivityIndicatorView!
    
    @IBOutlet var dogImage: UIImageView!
    
    var dogData: Dog!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dogData ?? "ERROR")
        getDogPic()
     
    }
    
    @IBAction func reload(_ sender: Any) {
        activity.startAnimating()
        fetchDog()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getDogPic()
        }
    }
    
   

}


// MARK: - Networking

extension DogViewController {
    private func fetchDog() {
        guard let url = URL(string: "https://random.dog/woof.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let test = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
                    self.dogData = test
                    print(self.dogData ?? "Nope")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func getDogPic() {
        guard let url = URL(string: dogData.url!) else { return }
       
        print("----------")
        print(url)
        print("YEAH!")
        print("----------")
       
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, let response = response else {
                        print(error?.localizedDescription ?? "No error description")
                        return
                    }
//                    print(response)
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.dogImage.image = image
                        self.activity.stopAnimating()
                    }
                }.resume()
        
        
    }
    
    
    
    
    
    
}
