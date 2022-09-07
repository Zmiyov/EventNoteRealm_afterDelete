//
//  DeadlineViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 07.09.2022.
//

import UIKit
import RealmSwift
import UserNotifications

class DeadlineViewController: UIViewController {
    
    let localRealm = try! Realm()
    var eventWithDeadlineArray: [EventRealmModel]!
    
    enum Section: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, EventRealmModel>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, EventRealmModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EventRealmModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(eventWithDeadlineArray)
        return snapshot
    }
    
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
        title = "Deadline"
        
        let date = Calendar.current.startOfDay(for: Date())
        datePredicate(date: date)

        
        collectionView.delegate = self
        
        setConstraints()
        
        createDataSource()
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
    
    func datePredicate() {
        
        let startOfTheDay = Date()
//        let endOfTheDay: Date = {
//            let components = DateComponents(day: 1, second: -1)
//            return Calendar.current.date(byAdding: components, to: startOfTheDay)!
//        }()
//
//        let predicate = NSPredicate(format: "dateAndTime BETWEEN %@", [startOfTheDay, endOfTheDay])
        let predicate = NSPredicate(format: "isDone == false && deadlineDate > %@", [startOfTheDay])
        
        let eventRealmModels = localRealm.objects(EventRealmModel.self).filter(predicate).sorted(byKeyPath: "deadlineDate")
        eventWithDeadlineArray = Array(eventRealmModels)
    }
}

    

//MARK: Collection View delegate

extension DeadlineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentEvent = eventWithDeadlineArray[indexPath.item]
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
            
            let markAsDone = UIAction(title: "Done") { action in
                let model = self.eventWithDeadlineArray[indexPath.item]
                RealmManager.shared.deleteEventModel(model: model)

                self.datePredicate(date: date)
                self.dataSource.apply(self.filteredItemsSnapshot, animatingDifferences: true)
                
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [markAsDone])
        }
        return config
    }
}

//MARK: Set Constraints

extension DeadlineViewController {
    
    func setConstraints() {
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


