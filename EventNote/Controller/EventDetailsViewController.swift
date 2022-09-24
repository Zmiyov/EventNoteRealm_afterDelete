//
//  EventDetailsViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit
import CoreLocation

class EventDetailsViewController: UIViewController {
    
    var event: EventEntity?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        dateFormatter.dateFormat = "YYYY, MMMM d"
        title = dateFormatter.string(from: event!.dateAndTime!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
        mainVerticalStackView()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func navigateWithAppTo(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let opt = MapAppOpt.mapsAlertController(coordinate: coordinate, name: "Destination", title: "Navigate to Destination", message: "Any message") { com in
            
        }
        self.present(opt, animated: true, completion: nil)
    }
    
    func prepareTapGestureToChooseMonth(label: UILabel) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        tapGesture.numberOfTapsRequired = 1
        
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
    }
    
    @objc func tapFunction() {
        
        navigateWithAppTo(latitude: event!.latitude, longitude: event!.longitude)
        
    }
    
    func mainVerticalStackView() {
        
        guard let event = event else { return }

        dateFormatter.dateFormat = "HH:mm"
        let timeOfShooting = dateFormatter.string(from: event.dateAndTime!)
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 40, weight: .bold), alighment: .center)
        let mainLocationLabel = UILabel(text: event.mainLocation ?? "", font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        
        let weatherImageView = UIImageView()
        weatherImageView.image = UIImage(named: "storm.png")
        
        let kindOfShootingLabel = UILabel(text: event.kindOfShooting ?? "", font: .systemFont(ofSize: 35, weight: .bold), alighment: .left)

        
        let amountOfHoursLabel = UILabel(text: "Amount of hours:" + " " + String(event.amountOfHours), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let nameLabel = UILabel(text: event.clientName!, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientPhoneNumberLabel = UILabel(text: event.clientPhoneNumber ?? "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let additionalPhoneNumberLabel = UILabel(text: event.additionalPhoneNumber ?? "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientTelegramOrChatLabel = UILabel(text: "Telegram:" + " " + (event.clientTelegramOrChat ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientInstagramLabel = UILabel(text: "Instagram:" + " " + (event.clientInstagram ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        
        let startLocationLabel = UILabel(text: "Start location:" + " " + (event.startLocation ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let endLocationLabel = UILabel(text: "End location:" + " " + (event.endLocation ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let fullPriceLabel = UILabel(text: "Full price:" + " " + (event.fullPrice ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let priceForHourLabel = UILabel(text: "Price for hour:" + " " + (event.priceForHour ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let prepaymentLabel = UILabel(text: "Prepayment:" + " " + (event.prepayment ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)

        let alertStringLabel = UILabel(text: "Alert: " + (event.alertString ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let emptyLabel = UILabel(text: "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        
        let mainVerticalStackView = UIStackView()
        
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.frame = CGRect(x: 0, y: 60, width: Constants.screenWidth, height: Constants.screenHeight-60)
        mainVerticalStackView.backgroundColor = .darkGray
        mainVerticalStackView.distribution = .fill
        mainVerticalStackView.spacing = 1
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainVerticalStackView)
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        let timeLocationWeatherHorStackView = UIStackView()
        timeLocationWeatherHorStackView.axis = .horizontal
        timeLocationWeatherHorStackView.distribution = .fillEqually
        timeLocationWeatherHorStackView.translatesAutoresizingMaskIntoConstraints = false

        
        let timeLocationVertStackView = UIStackView()
        timeLocationVertStackView.axis = .vertical
        timeLocationVertStackView.distribution = .fillEqually
        timeLocationVertStackView.spacing = 1
        timeLocationVertStackView.translatesAutoresizingMaskIntoConstraints = false
        
        timeLocationVertStackView.addArrangedSubview(dateAndTimeLabel)
        timeLocationVertStackView.addArrangedSubview(mainLocationLabel)
        
        if event.mainLocation != nil {
            prepareTapGestureToChooseMonth(label: mainLocationLabel)
        }
        
        timeLocationWeatherHorStackView.addArrangedSubview(timeLocationVertStackView)
        timeLocationWeatherHorStackView.addArrangedSubview(weatherImageView)
        
        if event.kindOfShooting != nil {
            mainVerticalStackView.addArrangedSubview(kindOfShootingLabel)
            NSLayoutConstraint.activate([
                kindOfShootingLabel.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
                kindOfShootingLabel.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
                kindOfShootingLabel.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
                kindOfShootingLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        mainVerticalStackView.addArrangedSubview(timeLocationWeatherHorStackView)
        NSLayoutConstraint.activate([
            timeLocationWeatherHorStackView.heightAnchor.constraint(equalToConstant: mainVerticalStackView.frame.width / 2 - 15)
        ])
        
        if event.amountOfHours != 0 {
            mainVerticalStackView.addArrangedSubview(amountOfHoursLabel)
        }
        
        if event.clientName != nil {
            mainVerticalStackView.addArrangedSubview(nameLabel)
            NSLayoutConstraint.activate([
                nameLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.clientPhoneNumber != nil {
            mainVerticalStackView.addArrangedSubview(clientPhoneNumberLabel)
            NSLayoutConstraint.activate([
                clientPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.additionalPhoneNumber != nil {
            mainVerticalStackView.addArrangedSubview(additionalPhoneNumberLabel)
            NSLayoutConstraint.activate([
                additionalPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.clientTelegramOrChat != nil {
            mainVerticalStackView.addArrangedSubview(clientTelegramOrChatLabel)
            NSLayoutConstraint.activate([
                clientTelegramOrChatLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.clientInstagram != nil {
            mainVerticalStackView.addArrangedSubview(clientInstagramLabel)
            NSLayoutConstraint.activate([
                clientInstagramLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.startLocation != nil {
            mainVerticalStackView.addArrangedSubview(startLocationLabel)
            NSLayoutConstraint.activate([
                startLocationLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.endLocation != nil {
            mainVerticalStackView.addArrangedSubview(endLocationLabel)
            NSLayoutConstraint.activate([
                endLocationLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.fullPrice != nil {
            mainVerticalStackView.addArrangedSubview(fullPriceLabel)
            NSLayoutConstraint.activate([
                fullPriceLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.priceForHour != nil {
            mainVerticalStackView.addArrangedSubview(priceForHourLabel)
            NSLayoutConstraint.activate([
                priceForHourLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.prepayment != nil {
            mainVerticalStackView.addArrangedSubview(prepaymentLabel)
            NSLayoutConstraint.activate([
                (prepaymentLabel).heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        if event.alertString != nil {
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
