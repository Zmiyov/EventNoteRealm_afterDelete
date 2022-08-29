//
//  EventDetailsViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var event: EventRealmModel?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
        verticalStackView()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func verticalStackView() {
        
        guard let event = event else {
            return
        }

        

        let kindOfShootingLabel = UILabel(text: event.kindOfShooting, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        dateFormatter.dateFormat = "HH:mm"
        let timeOfShooting = dateFormatter.string(from: event.dateAndTime)
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let amountOfHoursLabel = UILabel(text: "Amount of hours:" + " " + String(event.amountOfHours), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let nameLabel = UILabel(text: event.clientName, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientPhoneNumberLabel = UILabel(text: event.clientPhoneNumber, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let additionalPhoneNumberLabel = UILabel(text: event.additionalPhoneNumber, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientTelegramOrChatLabel = UILabel(text: "Telegram:" + " " + event.clientTelegramOrChat, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientInstagramLabel = UILabel(text: "Instagram:" + " " + event.clientInstagram, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let mainLocationLabel = UILabel(text: "Main location:" + " " + event.mainLocation, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let startLocationLabel = UILabel(text: "Start location:" + " " + event.startLocation, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let endLocationLabel = UILabel(text: "End location:" + " " + event.endLocation, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let priceLabel = UILabel(text: "Full price:" + " " + String(describing: event.fullPrice), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let priceForHourLabel = UILabel(text: "Price for hour:" + " " + event.priceForHour, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let prepaymentLabel = UILabel(text: "Prepayment:" + " " + event.prepayment, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let alertStringLabel = UILabel(text: "Alert: " + event.alertString, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        
        let verticalStackView = UIStackView()
        verticalStackView.backgroundColor = .darkGray
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 1
        
        if event.kindOfShooting != "" {
            verticalStackView.addArrangedSubview(kindOfShootingLabel)
        }
        
        verticalStackView.addArrangedSubview(dateAndTimeLabel)
        
        if event.amountOfHours != 0 {
            verticalStackView.addArrangedSubview(amountOfHoursLabel)
        }
        
        if event.clientName != "" {
            verticalStackView.addArrangedSubview(nameLabel)
        }
        
        if event.clientPhoneNumber != "" {
            verticalStackView.addArrangedSubview(clientPhoneNumberLabel)
        }
        
        if event.additionalPhoneNumber != "" {
            verticalStackView.addArrangedSubview(additionalPhoneNumberLabel)
        }
        
        if event.clientTelegramOrChat != "" {
            verticalStackView.addArrangedSubview(clientTelegramOrChatLabel)
        }
        
        if event.kindOfShooting != "" {
            verticalStackView.addArrangedSubview(clientInstagramLabel)
        }
        
        if event.clientInstagram != "" {
            verticalStackView.addArrangedSubview(mainLocationLabel)
        }
        
        if event.startLocation != "" {
            verticalStackView.addArrangedSubview(startLocationLabel)
        }
        
        if event.endLocation != "" {
            verticalStackView.addArrangedSubview(endLocationLabel)
        }
        
        if event.fullPrice != "" {
            verticalStackView.addArrangedSubview(priceLabel)
        }
        
        if event.priceForHour != "" {
            verticalStackView.addArrangedSubview(priceForHourLabel)
        }
        
        if event.prepayment != "" {
            verticalStackView.addArrangedSubview(prepaymentLabel)
        }
        
        if event.alertString != "" {
            verticalStackView.addArrangedSubview(alertStringLabel)
        }
        

        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
