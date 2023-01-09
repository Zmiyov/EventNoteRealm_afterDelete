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
    
    //MARK: - Gesture for Phone Number
    
    func prepareTapGestureToCallPhoneNumber(label: UILabel) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCallNumberFunction))
        tapGesture.numberOfTapsRequired = 1
        
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
    }
    
    @objc func tapCallNumberFunction() {
        guard let url = URL(string: "telprompt://\(event?.clientPhoneNumber ?? "")"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
        
        let nameLabel = UILabel(text: event.clientName!, font: .systemFont(ofSize: 32, weight: .bold), alighment: .left)
        
        //Time and Location block
        let timeOfShooting = dateFormatter.string(from: event.dateAndTime!)
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 40, weight: .bold), alighment: .center)
        let mainLocationLabel = UILabel(text: event.mainLocation ?? "", font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        mainLocationLabel.numberOfLines = 2
        mainLocationLabel.backgroundColor = .systemGreen
        
        
        //Kind and amount of hours block
        let kindOfShootingLabel = UILabel(text: event.kindOfShooting ?? "", font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        
        let amountOfHoursLabel = UILabel(text: String(event.amountOfHours) + " hour(s)", font: .systemFont(ofSize: 27, weight: .bold), alighment: .center)
        
        //Pricing block
        let fullPriceLabel = UILabel(text: "Full price:".localized() + " " + (event.fullPrice ?? ""), font: .systemFont(ofSize: 19, weight: .bold), alighment: .center)
        let prepaymentLabel = UILabel(text: "Prepayment:".localized() + " " + (event.prepayment ?? ""), font: .systemFont(ofSize: 19, weight: .bold), alighment: .center)
        
        //Contacts block
        let clientPhoneNumberLabel = UILabel(text: event.clientPhoneNumber ?? "", font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        let clientTelegramOrChatLabel = UILabel(text: "Telegram:" + " " + (event.clientTelegramOrChat ?? ""), font: .systemFont(ofSize: 19, weight: .bold), alighment: .left)
        let clientInstagramLabel = UILabel(text: "Instagram:" + " " + (event.clientInstagram ?? ""), font: .systemFont(ofSize: 19, weight: .bold), alighment: .left)
        
        //Notes block
        let notesLabel = UILabel(text: event.notes?.localized() ?? "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .left)
        
        //Alert block
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
        

        //Name block
        mainVerticalStackView.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainVerticalStackView.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor, constant: 0),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //Time and location block
        let timeLocationHorStackView = UIStackView()
        timeLocationHorStackView.axis = .horizontal
        timeLocationHorStackView.distribution = .fillEqually
        timeLocationHorStackView.translatesAutoresizingMaskIntoConstraints = false
        timeLocationHorStackView.backgroundColor = .tertiarySystemBackground
        timeLocationHorStackView.layer.cornerRadius = 8
        timeLocationHorStackView.clipsToBounds = true
        
        if event.mainLocation != nil {
            prepareTapGestureToChooseNavigator(label: mainLocationLabel)
        }
        
        timeLocationHorStackView.addArrangedSubview(dateAndTimeLabel)
        timeLocationHorStackView.addArrangedSubview(mainLocationLabel)
        
        mainVerticalStackView.addArrangedSubview(timeLocationHorStackView)
        NSLayoutConstraint.activate([
            timeLocationHorStackView.heightAnchor.constraint(equalToConstant: mainVerticalStackView.frame.width / 3 - 15)
        ])
        
        //Kind and amount of hours block
        let kindAndAmountHorStackView = UIStackView()
        kindAndAmountHorStackView.axis = .horizontal
        kindAndAmountHorStackView.distribution = .fillEqually
        kindAndAmountHorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        kindAndAmountHorStackView.addArrangedSubview(kindOfShootingLabel)
        kindAndAmountHorStackView.addArrangedSubview(amountOfHoursLabel)
        
        mainVerticalStackView.addArrangedSubview(kindAndAmountHorStackView)
        NSLayoutConstraint.activate([
            kindAndAmountHorStackView.heightAnchor.constraint(equalToConstant: mainVerticalStackView.frame.width / 4 - 15)
        ])
        
        //Pricing block
        let pricingHorStackView = UIStackView()
        pricingHorStackView.axis = .horizontal
        pricingHorStackView.distribution = .fillEqually
        pricingHorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        pricingHorStackView.addArrangedSubview(fullPriceLabel)
        pricingHorStackView.addArrangedSubview(prepaymentLabel)
        
        mainVerticalStackView.addArrangedSubview(pricingHorStackView)
        NSLayoutConstraint.activate([
            pricingHorStackView.heightAnchor.constraint(equalToConstant: mainVerticalStackView.frame.width / 4 - 15)
        ])
        
        
        //Contacts block
        
        prepareTapGestureToCallPhoneNumber(label: clientPhoneNumberLabel)
        mainVerticalStackView.addArrangedSubview(clientPhoneNumberLabel)
        NSLayoutConstraint.activate([
            clientPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        
        
        mainVerticalStackView.addArrangedSubview(clientTelegramOrChatLabel)
        NSLayoutConstraint.activate([
            clientTelegramOrChatLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        
        
        mainVerticalStackView.addArrangedSubview(clientInstagramLabel)
        NSLayoutConstraint.activate([
            clientInstagramLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        
        //Notes block
        
        //Notes block
        mainVerticalStackView.addArrangedSubview(alertStringLabel)
        NSLayoutConstraint.activate([
            alertStringLabel.heightAnchor.constraint(equalToConstant: 44),
            alertStringLabel.bottomAnchor.constraint(equalTo: mainVerticalStackView.bottomAnchor)
        ])
        
        //Empty block
        mainVerticalStackView.addArrangedSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
