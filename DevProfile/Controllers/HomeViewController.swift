//
//  ViewController.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    var gitHubUser : GithubUser?
    
    private let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
       
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let horizontalSecondStackView: UIStackView = {
       
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private let followersLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let followingLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let personImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .label
        return imageView
    }()
    
    private let repoImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "book.closed")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .label
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTitleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repoLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        horizontalStackView.addArrangedSubview(personImageView)
        horizontalStackView.addArrangedSubview(followersLabel)
        horizontalStackView.addArrangedSubview(followingLabel)
        
        horizontalSecondStackView.addArrangedSubview(repoImageView)
        horizontalSecondStackView.addArrangedSubview(projectLabel)
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameTitleLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(horizontalSecondStackView)
        
        configureConstraints()
        
        APICaller.shared.getGithupUser(with: UserData.shared.userName) { [weak self] result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.configure(with: titles)
                    self?.titleLabel.text = titles.login.capitalizeFirstLetter()
                    self?.nameTitleLabel.text = titles.name
                    self?.followersLabel.text = String(titles.followers) + " Followers"
                    self?.followingLabel.text = String(titles.following) + " Following"
                    self?.projectLabel.text = String(titles.publicRepos) + " Repositories"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func configureConstraints() {
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]

        let profileImageViewConstraints = [
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
            
        ]

        NSLayoutConstraint.activate(profileImageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }

    func configure(with model: GithubUser) {
        guard let url = URL(string: model.avatarUrl) else {
            return
        }
        
        profileImageView.sd_setImage(with: url, completed: nil)
    }

}

