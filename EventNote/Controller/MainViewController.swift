//
//  ViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 13.08.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class MainViewController: UIViewController {
    
    var calendarHeightConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    let localRealm = try! Realm()
    var eventRealmModelsArray: Results<EventRealmModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Schedule"
        
        let date = Date()
        print(date)
        datePredicate(date: date)

        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setConstraints()
        swipeAction()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc func addButtonTapped() {
        let addEventVC = AddEventTableViewController()
        let navController = UINavigationController(rootViewController: addEventVC)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        present(navController, animated: true)
    }
    
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
    }
    
//MARK: SwipeGestureRecognizer
    
    func swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
}

//MARK: - FSCalendarDataSource, FSCalendarDelegate

extension MainViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        datePredicate(date: date)
    }
    
    func datePredicate(date: Date) {
        
        let startOfTheDay = date
        let endOfTheDay: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: startOfTheDay)!
        }()
        
        let predicate = NSPredicate(format: "dateAndTime BETWEEN %@", [startOfTheDay, endOfTheDay])
        
        eventRealmModelsArray = localRealm.objects(EventRealmModel.self).filter(predicate).sorted(byKeyPath: "dateAndTime")
        collectionView.reloadData()
        print("predicate works")
    }
}

//MARK: Collection View

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventRealmModelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleCollectionViewCell
        let event = eventRealmModelsArray[indexPath.item]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: event.dateAndTime)
        cell.nameLabel.text = event.clientName
        cell.kindOfShootingLabel.text = event.kindOfShooting
        cell.timeLabel.text = time
        cell.locationLabel.text = event.mainLocation
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentEvent = eventRealmModelsArray[indexPath.item]
        let details = EventDetailsViewController()
        details.event = currentEvent
        let navVC = UINavigationController(rootViewController: details)
        navVC.modalPresentationStyle = .popover
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        navVC.navigationBar.standardAppearance = appearance
        navVC.navigationBar.scrollEdgeAppearance = appearance
        
        present(navVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
                
            let edit = UIAction(title: "Edit") { action in
                
                let addVC = AddEventTableViewController()
                addVC.eventModel = self.eventRealmModelsArray[indexPath.item]
                self.present(addVC, animated: true)
                
                print("Edit")
            }
            let delete = UIAction(title: "Delete") { action in
                let model = self.eventRealmModelsArray[indexPath.item]
                RealmManager.shared.deleteEventModel(model: model)
                collectionView.reloadData()
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [edit, delete])
        }
        return config
    }
}

//MARK: Set Constraints

extension MainViewController {
    
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        view.addSubview(showHideButton)
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
