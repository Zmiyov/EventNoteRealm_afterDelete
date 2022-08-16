//
//  EventDetailsViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        verticalStackView()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func verticalStackView() {
        
        guard let event = event else {
            return
        }

        
        let kindOfShootingLabel = UILabel(text: event.kindOfShooting,
                                          font: .systemFont(ofSize: 21, weight: .bold),
                                          alighment: .center)
        
        let nameLabel = UILabel(text: event.customerName,
                                font: .systemFont(ofSize: 21, weight: .bold),
                                alighment: .center)
        
        let locationLabel = UILabel(text: event.location,
                                    font: .systemFont(ofSize: 21, weight: .bold),
                                    alighment: .center)
        
        let customerPhoneNumberLabel = UILabel(text: String(describing: event.customerPhoneNumber),
                                               font: .systemFont(ofSize: 21, weight: .bold),
                                               alighment: .center)
        
        let priceLabel = UILabel(text: String(describing: event.price),
                                 font: .systemFont(ofSize: 21, weight: .bold),
                                 alighment: .center)

        

        
//        let horizontalStackView = UIStackView(arrangedSubviews: [])
        
        
        let verticalStackView = UIStackView(arrangedSubviews: [kindOfShootingLabel, nameLabel, locationLabel, customerPhoneNumberLabel, priceLabel])
        verticalStackView.frame = view.bounds
        verticalStackView.backgroundColor = .lightGray
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 20
        
        view.addSubview(verticalStackView)
        
    }

}
