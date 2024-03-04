//
//  ViewController.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(title: "Next")
        view.backgroundColor = .systemBackground
        
        title = "First Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupButton(title: String) {
        view.addSubview(nextButton)
        
        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .systemPink
        nextButton.configuration?.title = title
        
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func goToNextScreen() {
        let nextScreen = SecondViewController()
        
        nextScreen.title = "Second Screen"
        navigationController?.pushViewController(nextScreen, animated: true)
    }


}

