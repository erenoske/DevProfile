//
//  CollectionViewTableViewCell.swift
//  DevProfile
//
//  Created by eren on 11.03.2024.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

   static let identifier = "CollectionViewTableViewCell"
    
    private var titles: [GithupRepo] = [GithupRepo]()
    
    private let descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let starButton: UIButton = {
        
        let button = UIButton()
        let image = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let starLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "0"
        return label
    }()
    
    public func configure(with model: GithupRepo) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        starLabel.text = String(model.stargazersCount)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(starLabel)
        contentView.addSubview(starButton)
        contentView.addSubview(descriptionLabel)
        
        aplyConstraints()
    }
    
    private func aplyConstraints() {
        let nameLabelViewConstraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ]
        
        let descriptionLabelViewConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        
        let starButtonViewConstraints = [
            starButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            starButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        
        let starLabelViewConstraints = [
            starLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17.5),
            starLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35)
        ]
        
        NSLayoutConstraint.activate(nameLabelViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelViewConstraints)
        NSLayoutConstraint.activate(starButtonViewConstraints)
        NSLayoutConstraint.activate(starLabelViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
