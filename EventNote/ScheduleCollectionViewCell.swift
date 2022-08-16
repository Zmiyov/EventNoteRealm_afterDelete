//
//  ScheduleCollectionViewCell.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 17), alighment: .left)
    
    let kindOfShootingLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 17), alighment: .right)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
                                    ])
        
        addSubview(kindOfShootingLabel)
        kindOfShootingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([kindOfShootingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     kindOfShootingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
                                    ])
        
    }
}
