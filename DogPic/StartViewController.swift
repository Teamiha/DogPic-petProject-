//
//  ViewController.swift
//  DogPic
//
//  Created by Михаил Светлов on 12.04.2022.
//

import UIKit

class StartViewController: UIViewController {

    var dogCore: Dog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .light
        fetchDog()
    }

    @IBAction func start() {
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DogVC = segue.destination as? DogViewController else { return }
        DogVC.dogData = dogCore
        fetchDog()
    }

}

// MARK: - Networking

extension StartViewController {
    private func fetchDog() {
        guard let url = URL(string: "https://random.dog/woof.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                self.dogCore = try JSONDecoder().decode(Dog.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    
    
    
    
}
