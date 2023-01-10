//
//  DeadlineCollectionViewCell.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 07.09.2022.
//

import UIKit

class DeadlineCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), alighment: .left)
    let kindOfShootingLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let timeLabel = UILabel(font: UIFont.systemFont(ofSize: 17, weight: .regular), alighment: .left)
    let timeValueLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 20), alighment: .left)
    let leftDaysValueLabel = UILabel(font: UIFont.systemFont(ofSize: 35, weight: .heavy), alighment: .center)
    let leftDaysLabel = UILabel(font: UIFont.systemFont(ofSize: 11, weight: .regular), alighment: .center)
    
    
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
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
        
        addSubview(kindOfShootingLabel)
        kindOfShootingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            kindOfShootingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            kindOfShootingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
        ])
        
        addSubview(timeLabel)
        timeLabel.text = "Submit by: "
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
        
        addSubview(timeValueLabel)
        timeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeValueLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 3),
            timeValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)
        ])
        
        addSubview(leftDaysValueLabel)
        leftDaysValueLabel.textColor = .systemRed
        leftDaysValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftDaysValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            leftDaysValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
        
        addSubview(leftDaysLabel)
        leftDaysLabel.text = "day(s) left"
        leftDaysLabel.textColor = .systemRed
        leftDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftDaysLabel.topAnchor.constraint(equalTo: leftDaysValueLabel.bottomAnchor, constant: 0),
            leftDaysLabel.centerXAnchor.constraint(equalTo: leftDaysValueLabel.centerXAnchor)
        ])
    }
}
