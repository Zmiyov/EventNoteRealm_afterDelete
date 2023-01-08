//
//  EventDetailsViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit
import CoreLocation
import WeatherKit

class EventDetailsViewController: UIViewController {
    
    var event: EventEntity?
    let dateFormatter = DateFormatter()
    
    let service = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dateFormatter.dateFormat = "YYYY, MMMM d"
        title = dateFormatter.string(from: event!.dateAndTime!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close".localized(), style: .plain, target: self, action: #selector(dismissSelf))
        
        mainVerticalStackView()
//        displayWeather()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func displayWeather() {
        if let event = event {
            getWeather(latitude: event.latitude, longitude: event.longitude)
        }
    }
    
    //MARK: - Alert
    
    func navigateWithAppTo(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let opt = MapAppOpt.mapsAlertController(coordinate: coordinate, name: "Destination", title: "Navigate to Location".localized(), message: "Any message") { com in
        }
        self.present(opt, animated: true, completion: nil)
    }
    
    //MARK: - Gesture for location
    
    func prepareTapGestureToChooseNavigator(label: UILabel) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        tapGesture.numberOfTapsRequired = 1
        
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
    }
    
    @objc func tapFunction() {
        navigateWithAppTo(latitude: event!.latitude, longitude: event!.longitude)
    }
    
    //MARK: - Weather
    
    func getWeather(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        Task {
            do {
                let result = try await service.weather(for: location)
                print("Daily: " + String(describing: result.dailyForecast))
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - Stack View
    
    func mainVerticalStackView() {
        
        guard let event = event else { return }
        dateFormatter.dateFormat = "HH:mm"
        
        let timeOfShooting = dateFormatter.string(from: event.dateAndTime!)
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 40, weight: .bold), alighment: .center)
        let mainLocationLabel = UILabel(text: event.mainLocation ?? "", font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        mainLocationLabel.numberOfLines = 2
        mainLocationLabel.backgroundColor = .systemGreen
        
        
        let weatherImageView = UIImageView()
        weatherImageView.image = UIImage(named: "storm.png")
        
        let kindOfShootingLabel = UILabel(text: event.kindOfShooting ?? "", font: .systemFont(ofSize: 35, weight: .bold), alighment: .left)
        
        let amountOfHoursLabel = UILabel(text: "Amount of hours:".localized() + " " + String(event.amountOfHours), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        amountOfHoursLabel.backgroundColor = .tertiarySystemBackground
        amountOfHoursLabel.layer.cornerRadius = 8
        
        let nameLabel = UILabel(text: event.clientName!, font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientPhoneNumberLabel = UILabel(text: event.clientPhoneNumber ?? "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientTelegramOrChatLabel = UILabel(text: "Telegram:" + " " + (event.clientTelegramOrChat ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let clientInstagramLabel = UILabel(text: "Instagram:" + " " + (event.clientInstagram ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let fullPriceLabel = UILabel(text: "Full price:".localized() + " " + (event.fullPrice ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        let prepaymentLabel = UILabel(text: "Prepayment:".localized() + " " + (event.prepayment ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)

        let alertStringLabel = UILabel(text: "Alert: ".localized() + (event.alertString ?? ""), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        let emptyLabel = UILabel(text: "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        
        let mainVerticalStackView = UIStackView()
        
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.frame = CGRect(x: 0, y: 60, width: Constants.screenWidth, height: Constants.screenHeight-60)
        mainVerticalStackView.backgroundColor = .clear
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
        timeLocationWeatherHorStackView.backgroundColor = .tertiarySystemBackground
        timeLocationWeatherHorStackView.layer.cornerRadius = 8
        timeLocationWeatherHorStackView.clipsToBounds = true

        
//        let timeLocationVertStackView = UIStackView()
//        timeLocationVertStackView.axis = .vertical
//        timeLocationVertStackView.distribution = .fillEqually
//        timeLocationVertStackView.spacing = 1
//        timeLocationVertStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        timeLocationVertStackView.addArrangedSubview(dateAndTimeLabel)
//        timeLocationVertStackView.addArrangedSubview(mainLocationLabel)
        
        if event.mainLocation != nil {
            prepareTapGestureToChooseNavigator(label: mainLocationLabel)
        }
        
        timeLocationWeatherHorStackView.addArrangedSubview(dateAndTimeLabel)
        timeLocationWeatherHorStackView.addArrangedSubview(mainLocationLabel)
        
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
            NSLayoutConstraint.activate([
                amountOfHoursLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
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
        
        if event.fullPrice != nil {
            mainVerticalStackView.addArrangedSubview(fullPriceLabel)
            NSLayoutConstraint.activate([
                fullPriceLabel.heightAnchor.constraint(equalToConstant: 44)
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
