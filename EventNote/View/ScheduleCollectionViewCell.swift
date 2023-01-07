//
//  ScheduleCollectionViewCell.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 20), alighment: .left)
    let kindOfShootingLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 17), alighment: .right)
    let timeLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 30), alighment: .left)
    let locationLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 17), alighment: .right)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
//        backgroundColor = .tertiarySystemBackground
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
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
                                    ])
        
        addSubview(locationLabel)
        locationLabel.numberOfLines = 2
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
                                     locationLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
                                    ])
        
    }
}
