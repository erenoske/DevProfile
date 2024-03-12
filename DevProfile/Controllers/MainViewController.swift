//
//  ViewController.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    var gitHubUser : GithubUser?
    
    private let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let projectButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Projects", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let projectLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 100 / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.label.cgColor
        return imageView
    }()

    
    private let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let nameTitleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(nameTitleLabel)
        stackView.addArrangedSubview(projectLabel)
        stackView.addArrangedSubview(projectButton)
        
        projectButton.addTarget(self, action: #selector(goToSecondScreen), for: .touchUpInside)
        
        configureConstraints()
        
        title = "Githup Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        APICaller.shared.getGithupUser(with: UserData.shared.userName) { [weak self] result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.configure(with: titles)
                    self?.titleLabel.text = titles.login.capitalizeFirstLetter()
                    self?.nameTitleLabel.text = titles.name
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    @objc func goToSecondScreen() {
        let screen = SecondViewController()
        
        screen.title = "Projects"
        navigationController?.pushViewController(screen, animated: true)
    }
    
    func configureConstraints() {
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let profileImageViewConstraints = [
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
            
        ]
        
        let projectButtonConstraints = [
            projectButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        
        NSLayoutConstraint.activate(profileImageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(projectButtonConstraints)
    }

    func configure(with model: GithubUser) {
        guard let url = URL(string: model.avatarUrl) else {
            return
        }
        
        profileImageView.sd_setImage(with: url, completed: nil)
    }

}

