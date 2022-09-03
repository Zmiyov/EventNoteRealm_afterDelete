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
//        navigationController?.navigationBar.prefersLargeTitles = true
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
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 30, weight: .bold), alighment: .center)
        let mainLocationLabel = UILabel(text: "Main location:" + " " + event.mainLocation, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
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
        
        
        
        
        let mainVerticalStackView = UIStackView()
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
            mainVerticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
        
        
        let timeLocationWeatherHorStackView = UIStackView()
        timeLocationWeatherHorStackView.axis = .horizontal
        timeLocationWeatherHorStackView.distribution = .fillEqually
        timeLocationWeatherHorStackView.spacing = 1
        timeLocationWeatherHorStackView.translatesAutoresizingMaskIntoConstraints = false

        
        let timeLocationVertStackView = UIStackView()
        timeLocationVertStackView.axis = .vertical
        timeLocationVertStackView.distribution = .fillEqually
        timeLocationVertStackView.spacing = 1
        timeLocationVertStackView.translatesAutoresizingMaskIntoConstraints = false

        

        

        
        
        
        if event.kindOfShooting != "" {
            mainVerticalStackView.addArrangedSubview(kindOfShootingLabel)
            NSLayoutConstraint.activate([
                kindOfShootingLabel.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
                kindOfShootingLabel.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
                kindOfShootingLabel.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
                kindOfShootingLabel.bottomAnchor.constraint(equalTo: timeLocationWeatherHorStackView.topAnchor, constant: 0),
                kindOfShootingLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        mainVerticalStackView.addSubview(timeLocationWeatherHorStackView)
        NSLayoutConstraint.activate([
//            timeLocationWeatherHorStackView.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
//            timeLocationWeatherHorStackView.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
//            timeLocationWeatherHorStackView.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
            timeLocationWeatherHorStackView.heightAnchor.constraint(equalToConstant: 150)
//                kindOfShootingLabel.bottomAnchor.constraint(equalTo: timeLocationWeatherHorStackView.bottomAnchor, constant: 0)
        ])
        
        
        timeLocationWeatherHorStackView.addSubview(timeLocationVertStackView)
        NSLayoutConstraint.activate([
//            timeLocationVertStackView.topAnchor.constraint(equalTo: timeLocationWeatherHorStackView.topAnchor, constant: 0),
//            timeLocationVertStackView.leadingAnchor.constraint(equalTo: timeLocationWeatherHorStackView.leadingAnchor, constant: 0),
//            timeLocationVertStackView.trailingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 0),
//            timeLocationVertStackView.heightAnchor.constraint(equalToConstant: 300),
//            timeLocationVertStackView.widthAnchor.constraint(equalToConstant: timeLocationWeatherHorStackView.bounds.width / 2)
//                kindOfShootingLabel.bottomAnchor.constraint(equalTo: timeLocationWeatherHorStackView.bottomAnchor, constant: 0)
        ])
        
        timeLocationWeatherHorStackView.addSubview(weatherImageView)
        
        timeLocationVertStackView.addSubview(dateAndTimeLabel)
        timeLocationVertStackView.addSubview(mainLocationLabel)
        
        
        if event.amountOfHours != 0 {
            mainVerticalStackView.addArrangedSubview(amountOfHoursLabel)
        }
        
        if event.clientName != "" {
            mainVerticalStackView.addArrangedSubview(nameLabel)
        }
        
        if event.clientPhoneNumber != "" {
            mainVerticalStackView.addArrangedSubview(clientPhoneNumberLabel)
        }
        
        if event.additionalPhoneNumber != "" {
            mainVerticalStackView.addArrangedSubview(additionalPhoneNumberLabel)
        }
        
        if event.clientTelegramOrChat != "" {
            mainVerticalStackView.addArrangedSubview(clientTelegramOrChatLabel)
        }
        
        if event.clientInstagram != "" {
            mainVerticalStackView.addArrangedSubview(clientInstagramLabel)
        }
        
        if event.startLocation != "" {
            mainVerticalStackView.addArrangedSubview(startLocationLabel)
        }
        
        if event.endLocation != "" {
            mainVerticalStackView.addArrangedSubview(endLocationLabel)
        }
        
        if event.fullPrice != "" {
            mainVerticalStackView.addArrangedSubview(priceLabel)
        }
        
        if event.priceForHour != "" {
            mainVerticalStackView.addArrangedSubview(priceForHourLabel)
        }
        
        if event.prepayment != "" {
            mainVerticalStackView.addArrangedSubview(prepaymentLabel)
        }
        
        if event.alertString != "" {
            mainVerticalStackView.addArrangedSubview(alertStringLabel)
        }
    }
}
