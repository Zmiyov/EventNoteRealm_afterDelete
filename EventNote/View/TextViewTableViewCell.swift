//
//  TextViewTableViewCell.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 09.01.2023.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16.0)
        textView.text = "Placeholder"
        textView.textColor = UIColor.lightGray
        
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupPlaceholder()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }
    
    private func setupPlaceholder() {
        
    }
    
    private func setupView() {
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor , constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        self.contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor , constant: 5),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}

