//
//  SecondViewController.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import UIKit

class SecondViewController: UIViewController {

    var githubManager = GithubManager()
    var user: GithubUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        
        loadUserData()

    }
    
    func loadUserData() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 600, y: 0, width: 100, height: 100)
        imageView.center = view.center
        view.addSubview(imageView)
        
        Task {
            do {
                user = try await githubManager.getUser()
                DispatchQueue.main.async {
                    self.updateLabel()
                    let url = URL(string: self.user!.avatarUrl)!
                    
                    self.loadImage(from: url) { image in
                        if let image = image {
                            imageView.image = image
                        } else {
                            print("Resim yüklenemedi")
                        }
                    }
                }
            } catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid response")
            } catch GHError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    func updateLabel() {
        let label = UILabel()
        label.text = user?.login
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }.resume()
    }
}


