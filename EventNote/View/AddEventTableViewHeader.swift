//
//  AddEventTableViewHeader.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit

class AddEventTableViewHeader: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "", font: .systemFont(ofSize: 20), alighment: .left)
    
    let headerNameArray = ["Main", "Contacts", "Location", "Payment", "Reminder"]
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        
        self.addSubview(headerLabel)
        headerLabel.backgroundColor = .clear
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
    }
    
    func headerConfigure(section: Int) {
        headerLabel.text = headerNameArray[section]
    }
    
    
}
