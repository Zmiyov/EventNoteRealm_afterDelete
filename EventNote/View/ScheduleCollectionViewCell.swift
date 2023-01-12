//
//  ScheduleCollectionViewCell.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), alighment: .left)
    let kindOfShootingLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let timeLabel = UILabel(font: UIFont.systemFont(ofSize: 33, weight: .semibold), alighment: .left)
    let locationLabel = UILabel(font: UIFont.systemFont(ofSize: 19, weight: .regular), alighment: .right)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        layer.cornerRadius = 12
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
                                    ])
        
        addSubview(kindOfShootingLabel)
        kindOfShootingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([kindOfShootingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     kindOfShootingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
                                    ])
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
                                    ])
        
        addSubview(locationLabel)
        locationLabel.numberOfLines = 2
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
                                     locationLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
                                    ])
        
    }
}
