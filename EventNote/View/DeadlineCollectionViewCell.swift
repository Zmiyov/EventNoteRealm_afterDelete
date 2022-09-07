//
//  DeadlineCollectionViewCell.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 07.09.2022.
//

import UIKit

class DeadlineCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 20), alighment: .left)
    let kindOfShootingLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 17), alighment: .right)
    let timeLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 20), alighment: .left)
    let contactsLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 17), alighment: .right)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = .tertiarySystemBackground
        layer.cornerRadius = 12
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
                                    ])
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
                                    ])
        
        addSubview(kindOfShootingLabel)
        kindOfShootingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([kindOfShootingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     kindOfShootingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
                                    ])
        
        addSubview(contactsLabel)
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([contactsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     contactsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
                                    ])
        
    }
}
