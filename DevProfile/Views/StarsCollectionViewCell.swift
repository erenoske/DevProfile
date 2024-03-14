//
//  StarsCollectionViewCell.swift
//  DevProfile
//
//  Created by eren on 12.03.2024.
//

import UIKit

class StarsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StarsCollectionViewCell"
    
    private let myImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func configureStars(with model: GithupRepo) {
        
        guard let url = URL(string: model.owner.avatarUrl) else {
            return
        }
        
        self.myImageView.sd_setImage(with: url, completed: nil)
        
        self.nameLabel.text = model.name
        
        self.addSubview(nameLabel)
        self.addSubview(myImageView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let myImageViewConstraints = [
            myImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ]
        let nameLabelViewConstraints = [
            nameLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(nameLabelViewConstraints)
        NSLayoutConstraint.activate(myImageViewConstraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    }
    
}
