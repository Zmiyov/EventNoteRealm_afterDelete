//
//  ViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 13.08.2022.
//

import UIKit
import FSCalendar
import RealmSwift
import UserNotifications

class MainViewController: UIViewController {
    
    var calendarHeightConstraint: NSLayoutConstraint!
    var choosedDay = Calendar.current.startOfDay(for: Date())
    
    let localRealm = try! Realm()
    var eventRealmModelsArray: [EventRealmModel]!
    
    enum Section: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, EventRealmModel>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, EventRealmModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EventRealmModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(eventRealmModelsArray)
        return snapshot
    }
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.weekdayTextColor = .systemRed
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17)
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 20)
        
        return calendar
    }()
    
    let showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Schedule"
        
        let date = Calendar.current.startOfDay(for: Date())
        datePredicate(date: date)

        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchDown)
        
        collectionView.delegate = self
        
        setConstraints()
        swipeAction()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        createDataSource()
    }
    
    @objc func addButtonTapped() {
        let addEventVC = AddEventTableViewController()
        addEventVC.editedDay = choosedDay
        addEventVC.delegate = self
        let navController = UINavigationController(rootViewController: addEventVC)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        present(navController, animated: true)
    }
    
    @objc func showHideButtonTapped() {
        animateButton()
        perform(#selector(showHideCalendar), with: nil, afterDelay: 0.2)

    }
    
    @objc func showHideCalendar() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
    }
    
    func animateButton() {
        UIView.animate(withDuration: 0.2, animations: {self.showHideButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)}) { finish in
            UIView.animate(withDuration: 0.1) {
                self.showHideButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc func todayButtonTapped() {
        calendar.select(Date(), scrollToDate: true)
        let date = Calendar.current.startOfDay(for: Date())
        datePredicate(date: date)
        dataSource.apply(filteredItemsSnapshot, animatingDifferences: true)
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
    
    //MARK: Collection view data source
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, EventRealmModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleCollectionViewCell
            
            let event = item
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.string(from: event.dateAndTime)
            cell.nameLabel.text = event.clientName
            cell.kindOfShootingLabel.text = event.kindOfShooting
            cell.timeLabel.text = time
            cell.locationLabel.text = event.mainLocation
            
            return cell
        })
        
        dataSource.apply(filteredItemsSnapshot)
    }
}

//MARK: - FSCalendarDataSource, FSCalendarDelegate

extension MainViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let startOfTheDay = date
        let endOfTheDay: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: startOfTheDay)!
        }()
        let predicate = NSPredicate(format: "dateAndTime BETWEEN %@", [startOfTheDay, endOfTheDay])
        let eventRealmModelsArray = localRealm.objects(EventRealmModel.self).filter(predicate)
        
        if eventRealmModelsArray.count != 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        choosedDay = date
        datePredicate(date: date)
        dataSource.apply(filteredItemsSnapshot, animatingDifferences: true)
    }
    
    func datePredicate(date: Date) {
        
        let startOfTheDay = date
        let endOfTheDay: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: startOfTheDay)!
        }()
        
        let predicate = NSPredicate(format: "dateAndTime BETWEEN %@", [startOfTheDay, endOfTheDay])
        
        let eventRealmModels = localRealm.objects(EventRealmModel.self).filter(predicate).sorted(byKeyPath: "dateAndTime")
        eventRealmModelsArray = Array(eventRealmModels)
    }
}

//MARK: Collection View delegate

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
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
                
                let editVC = AddEventTableViewController()
                editVC.eventModel = self.eventRealmModelsArray[indexPath.item]
                editVC.editedDay = self.eventRealmModelsArray[indexPath.item].dateAndTime
                editVC.delegate = self
                
                let navController = UINavigationController(rootViewController: editVC)
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                navController.navigationBar.standardAppearance = appearance
                navController.navigationBar.scrollEdgeAppearance = appearance
                
                self.present(navController, animated: true)
            }
            
            let delete = UIAction(title: "Delete") { action in
                let model = self.eventRealmModelsArray[indexPath.item]
                RealmManager.shared.deleteEventModel(model: model)
                let date = self.choosedDay
                self.datePredicate(date: date)
                self.dataSource.apply(self.filteredItemsSnapshot, animatingDifferences: true)
                self.calendar.reloadData()
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
        collectionView.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension MainViewController: AddEventTableViewControllerDelegate {
    
    func addEventTableViewController(_ controller: AddEventTableViewController, event: EventRealmModel) {
        let date = choosedDay
        datePredicate(date: date)
        dataSource.apply(filteredItemsSnapshot, animatingDifferences: true)
        if let date = event.alertDate {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.identifierID])
            ShootingReminder.shared.schedule(date: date, title: event.clientName, body: event.kindOfShooting, identifier: event.identifierID)
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.identifierID])
        }
//        print("Now date in delegate", Date())
//        print("Identifier in delegate", event.identifierID)
//        print("Date of reminder", event.alertDate)
        calendar.reloadData()
    }
}
