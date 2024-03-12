//
//  HeaderUIView.swift
//  DevProfile
//
//  Created by eren on 11.03.2024.
//

import UIKit

class HeaderUIView: UIView {
    
    private let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(nameTitleLabel)
        
        aplyConstraints()
    }
    
    private func aplyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        let profileImageViewConstraints = [
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
            
        ]
        
        NSLayoutConstraint.activate(profileImageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    public func configureHeader(with model: HeaderViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = model.login
            self.nameTitleLabel.text = model.name
            
            guard let url = URL(string: model.avatarUrl) else {
                return
            }
            
            self.profileImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
