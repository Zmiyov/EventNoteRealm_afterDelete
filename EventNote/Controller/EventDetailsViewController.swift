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
    
//    let service = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        dateFormatter.dateFormat = "YYYY, MMMM d"
        title = dateFormatter.string(from: event!.dateAndTime!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close".localized(), style: .plain, target: self, action: #selector(dismissSelf))
        
        mainVerticalStackView()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
//    func displayWeather() {
//        if let event = event {
//            getWeather(latitude: event.latitude, longitude: event.longitude)
//        }
//    }
    
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
    
//    func getWeather(latitude: Double, longitude: Double) {
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        Task {
//            do {
//                let result = try await service.weather(for: location)
//                print("Daily: " + String(describing: result.dailyForecast))
//            } catch {
//                print(error)
//            }
//        }
//    }
    
    //MARK: - Stack View
    
    func mainVerticalStackView() {
        
        guard let event = event else { return }
        dateFormatter.dateFormat = "HH:mm"
        
        let nameLabel = UILabel(text: event.clientName!, font: .systemFont(ofSize: 32, weight: .bold), alighment: .left)
        
        //Time and Location block
        let timeOfShooting = dateFormatter.string(from: event.dateAndTime!)
        
        let dateAndTimeLabel = UILabel(text: timeOfShooting, font: .systemFont(ofSize: 40, weight: .bold), alighment: .center)
        dateAndTimeLabel.backgroundColor = .tertiarySystemBackground
        let mainLocationLabel = UILabel(text: event.mainLocation ?? "None".localized(), font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        mainLocationLabel.numberOfLines = 2
        mainLocationLabel.backgroundColor = .systemGreen
        
        
        //Kind and amount of hours block
        let kindOfShootingLabel = UILabel(text: event.kindOfShooting?.localized() ?? "None".localized(), font: .systemFont(ofSize: 25, weight: .bold), alighment: .center)
        
        let amountOfHoursLabel = UILabel(text: String(event.amountOfHours) + " hour(s)", font: .systemFont(ofSize: 27, weight: .bold), alighment: .center)
        
        //Pricing block
        let fullPriceLabel = UILabel(text: "Full price:".localized() + " " + (event.fullPrice ?? "None".localized()), font: .systemFont(ofSize: 19, weight: .bold), alighment: .center)
        fullPriceLabel.layer.borderWidth = 1
        fullPriceLabel.layer.borderColor = UIColor.systemGray.cgColor
        fullPriceLabel.numberOfLines = 2
        
        let prepaymentLabel = UILabel(text: "Deposit:".localized() + " " + (event.prepayment ?? "None".localized()), font: .systemFont(ofSize: 19, weight: .bold), alighment: .center)
        prepaymentLabel.numberOfLines = 2
        
        //Contacts block
        let clientPhoneNumberLabel = UILabel(text: event.clientPhoneNumber ?? "", font: .systemFont(ofSize: 24, weight: .bold), alighment: .center)
        let clientTelegramOrChatLabel = UILabel(text: "Telegram:" + " " + (event.clientTelegramOrChat ?? "None".localized()), font: .systemFont(ofSize: 19, weight: .bold), alighment: .left)
        let clientInstagramLabel = UILabel(text: "Instagram:" + " " + (event.clientInstagram ?? "None".localized()), font: .systemFont(ofSize: 19, weight: .bold), alighment: .left)
        
        //Notes block
//        let notesLabel = UILabel(text: event.notes?.localized() ?? "None".localized(), font: .systemFont(ofSize: 21, weight: .bold), alighment: .left)
        
        let notesTextView = UITextView()
        notesTextView.text = event.notes?.localized() ?? "None".localized()
        notesTextView.font = .systemFont(ofSize: 17, weight: .regular)
        notesTextView.isEditable = false
        notesTextView.layer.borderColor = UIColor.systemGray.cgColor
        notesTextView.layer.borderWidth = 2
        notesTextView.layer.cornerRadius = 8
        
        //Alert block
        let alertStringLabel = UILabel(text: "Alert: ".localized() + (event.alertString?.localized() ?? "None".localized()), font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        alertStringLabel.contentMode = .bottom
        
        let emptyLabel = UILabel(text: "", font: .systemFont(ofSize: 21, weight: .bold), alighment: .center)
        
        //Scroll View
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //Main Stack
        let mainVerticalStackView = UIStackView()
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.backgroundColor = .clear
        mainVerticalStackView.distribution = .fill
        mainVerticalStackView.spacing = 1
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(mainVerticalStackView)
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainVerticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
            timeLocationHorStackView.heightAnchor.constraint(equalToConstant: view.frame.width / 3 - 15)
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
            kindAndAmountHorStackView.heightAnchor.constraint(equalToConstant: view.frame.width / 4 - 15)
        ])
        
        //Pricing block
        let pricingHorStackView = UIStackView()
        pricingHorStackView.axis = .horizontal
        pricingHorStackView.distribution = .fillEqually
        pricingHorStackView.translatesAutoresizingMaskIntoConstraints = false
        pricingHorStackView.layer.cornerRadius = 8
        pricingHorStackView.clipsToBounds = true
        pricingHorStackView.layer.borderWidth = 3
        pricingHorStackView.layer.borderColor = UIColor.systemGray.cgColor
        
        pricingHorStackView.addArrangedSubview(fullPriceLabel)
        pricingHorStackView.addArrangedSubview(prepaymentLabel)
        
        mainVerticalStackView.addArrangedSubview(pricingHorStackView)
        NSLayoutConstraint.activate([
            pricingHorStackView.heightAnchor.constraint(equalToConstant: view.frame.width / 4 - 15)
        ])
        
        
        //Contacts block
        
        prepareTapGestureToCallPhoneNumber(label: clientPhoneNumberLabel)
        mainVerticalStackView.addArrangedSubview(clientPhoneNumberLabel)
        NSLayoutConstraint.activate([
            clientPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 64)
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
        
        mainVerticalStackView.addArrangedSubview(notesTextView)
        NSLayoutConstraint.activate([
            notesTextView.topAnchor.constraint(equalTo: clientInstagramLabel.bottomAnchor),
//            notesTextView.bottomAnchor.constraint(equalTo: alertStringLabel.topAnchor)
            notesTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        //Alert block
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
