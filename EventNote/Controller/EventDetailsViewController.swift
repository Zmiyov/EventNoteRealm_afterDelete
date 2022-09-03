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
        view.backgroundColor = .tertiarySystemBackground
        dateFormatter.dateFormat = "YYYY, MMMM d"
        title = dateFormatter.string(from: event!.dateAndTime)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
        mainVerticalStackView()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func mainVerticalStackView() {
        
        guard let event = event else { return }

        dateFormatter.dateFormat = "HH:mm"
        let timeOfShooting = dateFormatter.string(from: event.dateAndTime)
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 40, weight: .bold), alighment: .center)
        let mainLocationLabel = UILabel(text: event.mainLocation, font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        
        let weatherImageView = UIImageView()
        weatherImageView.image = UIImage(named: "storm.png")
        
        let kindOfShootingLabel = UILabel(text: event.kindOfShooting, font: .systemFont(ofSize: 35, weight: .bold), alighment: .left)

        
        let amountOfHoursLabel = UILabel(text: "Amount of hours:" + " " + String(event.amountOfHours), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let nameLabel = UILabel(text: event.clientName, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientPhoneNumberLabel = UILabel(text: event.clientPhoneNumber, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let additionalPhoneNumberLabel = UILabel(text: event.additionalPhoneNumber, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientTelegramOrChatLabel = UILabel(text: "Telegram:" + " " + event.clientTelegramOrChat, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientInstagramLabel = UILabel(text: "Instagram:" + " " + event.clientInstagram, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        
        let startLocationLabel = UILabel(text: "Start location:" + " " + event.startLocation, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let endLocationLabel = UILabel(text: "End location:" + " " + event.endLocation, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let priceLabel = UILabel(text: "Full price:" + " " + String(describing: event.fullPrice), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let priceForHourLabel = UILabel(text: "Price for hour:" + " " + event.priceForHour, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let prepaymentLabel = UILabel(text: "Prepayment:" + " " + event.prepayment, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)

        let alertStringLabel = UILabel(text: "Alert: " + event.alertString, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let emptyLabel = UILabel(text: "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        
        
        
        let mainVerticalStackView = UIStackView(frame: .zero)
        mainVerticalStackView.backgroundColor = .darkGray
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.distribution = .fill
        mainVerticalStackView.spacing = 1
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainVerticalStackView)
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//            mainVerticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
        
        let timeLocationWeatherHorStackView = UIStackView(frame: .zero)
        timeLocationWeatherHorStackView.axis = .horizontal
        timeLocationWeatherHorStackView.distribution = .fillEqually
        timeLocationWeatherHorStackView.spacing = 1
        timeLocationWeatherHorStackView.translatesAutoresizingMaskIntoConstraints = false

        
        let timeLocationVertStackView = UIStackView()
        timeLocationVertStackView.axis = .vertical
        timeLocationVertStackView.distribution = .fillEqually
        timeLocationVertStackView.spacing = 1
        timeLocationVertStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //            timeLocationVertStackView.topAnchor.constraint(equalTo: timeLocationWeatherHorStackView.topAnchor, constant: 0),
            //            timeLocationVertStackView.leadingAnchor.constraint(equalTo: timeLocationWeatherHorStackView.leadingAnchor, constant: 0),
            //            timeLocationVertStackView.trailingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 0),
            timeLocationVertStackView.heightAnchor.constraint(equalToConstant: 200),

        ])
        
        timeLocationVertStackView.addArrangedSubview(dateAndTimeLabel)
        timeLocationVertStackView.addArrangedSubview(mainLocationLabel)
        
        timeLocationWeatherHorStackView.addArrangedSubview(timeLocationVertStackView)
        timeLocationWeatherHorStackView.addArrangedSubview(weatherImageView)
        
        
        
        if event.kindOfShooting != "" {
            mainVerticalStackView.addArrangedSubview(kindOfShootingLabel)
            NSLayoutConstraint.activate([
                kindOfShootingLabel.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
                kindOfShootingLabel.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
                kindOfShootingLabel.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
                kindOfShootingLabel.heightAnchor.constraint(equalToConstant: 50)
//                kindOfShootingLabel.bottomAnchor.constraint(equalTo: timeLocationWeatherHorStackView.bottomAnchor, constant: 0)
            ])
        }
        
        mainVerticalStackView.addArrangedSubview(timeLocationWeatherHorStackView)
        NSLayoutConstraint.activate([
//            timeLocationWeatherHorStackView.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
//            timeLocationWeatherHorStackView.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
//            timeLocationWeatherHorStackView.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
            timeLocationWeatherHorStackView.heightAnchor.constraint(equalToConstant: 200),
//            timeLocationWeatherHorStackView.bottomAnchor.constraint(equalTo: timeLocationWeatherHorStackView.bottomAnchor, constant: 0)
        ])
        
        
        if event.amountOfHours != 0 {
            mainVerticalStackView.addArrangedSubview(amountOfHoursLabel)
        }
        
        if event.clientName != "" {
            mainVerticalStackView.addArrangedSubview(nameLabel)
            NSLayoutConstraint.activate([
//                nameLabel.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
//                nameLabel.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
//                nameLabel.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
//                nameLabel.bottomAnchor.constraint(equalTo: timeLocationWeatherHorStackView.bottomAnchor, constant: 0),
                nameLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.clientPhoneNumber != "" {
            mainVerticalStackView.addArrangedSubview(clientPhoneNumberLabel)
            NSLayoutConstraint.activate([
                clientPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.additionalPhoneNumber != "" {
            mainVerticalStackView.addArrangedSubview(additionalPhoneNumberLabel)
            NSLayoutConstraint.activate([
                additionalPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.clientTelegramOrChat != "" {
            mainVerticalStackView.addArrangedSubview(clientTelegramOrChatLabel)
            NSLayoutConstraint.activate([
                clientTelegramOrChatLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.clientInstagram != "" {
            mainVerticalStackView.addArrangedSubview(clientInstagramLabel)
            NSLayoutConstraint.activate([
                clientInstagramLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.startLocation != "" {
            mainVerticalStackView.addArrangedSubview(startLocationLabel)
            NSLayoutConstraint.activate([
                startLocationLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.endLocation != "" {
            mainVerticalStackView.addArrangedSubview(endLocationLabel)
            NSLayoutConstraint.activate([
                endLocationLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.fullPrice != "" {
            mainVerticalStackView.addArrangedSubview(priceLabel)
            NSLayoutConstraint.activate([
                priceLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.priceForHour != "" {
            mainVerticalStackView.addArrangedSubview(priceForHourLabel)
            NSLayoutConstraint.activate([
                priceForHourLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.prepayment != "" {
            mainVerticalStackView.addArrangedSubview(prepaymentLabel)
            NSLayoutConstraint.activate([
                (prepaymentLabel).heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.alertString != "" {
            mainVerticalStackView.addArrangedSubview(alertStringLabel)
            NSLayoutConstraint.activate([
                alertStringLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        mainVerticalStackView.addArrangedSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
