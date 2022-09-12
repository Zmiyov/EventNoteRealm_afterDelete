//
//  DeadlineViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 07.09.2022.
//

import UIKit
import CoreData
//import RealmSwift

class DeadlineViewController: UIViewController {
    
//    let localRealm = try! Realm()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var eventWithDeadlineArray: [EventEntity]!
    
    enum Section: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, EventEntity>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, EventEntity> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EventEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(eventWithDeadlineArray)
        return snapshot
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DeadlineCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Deadlines"
        
        setConstraints()
//        datePredicate()
        fetchEvents()
        collectionView.delegate = self
        createDataSource()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        datePredicate()
        fetchEvents()
        self.dataSource.apply(self.filteredItemsSnapshot, animatingDifferences: false)
    }
    
    //MARK: Collection view data source
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, EventEntity>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DeadlineCollectionViewCell
            
            let event = item
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY, MMMM d"
            guard let deadlineDate = event.deadlineDate else { return nil }
            let time = dateFormatter.string(from: deadlineDate)
            cell.nameLabel.text = event.clientName
            cell.kindOfShootingLabel.text = event.kindOfShooting
            cell.timeLabel.text = time
            cell.contactsLabel.text = event.clientPhoneNumber
            
            return cell
        })
        
        dataSource.apply(filteredItemsSnapshot)
    }
    
//    func datePredicate() {
//        let startOfTheDay = Calendar.current.startOfDay(for: Date()) as NSDate
//        let predicate = NSPredicate(format: "isDone == false && deadlineDate > %@", startOfTheDay)
//        let eventRealmModels = localRealm.objects(EventRealmModel.self).filter(predicate).sorted(byKeyPath: "deadlineDate")
//        eventWithDeadlineArray = Array(eventRealmModels)
//    }
    
    func fetchEvents() {
        
        let startOfTheDay = Calendar.current.startOfDay(for: Date()) as NSDate
        
        do {
            let request = EventEntity.fetchRequest() as NSFetchRequest<EventEntity>
            let predicate = NSPredicate(format: "isDone == false && deadlineDate > %@", startOfTheDay)
            request.predicate = predicate
            let sortByDate = NSSortDescriptor(key: "deadlineDate", ascending: true)
            request.sortDescriptors = [sortByDate]
            
            let eventModelsArray = try context.fetch(request)
            self.eventWithDeadlineArray = eventModelsArray
        } catch {
            print(error)
        }
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
//                try! self.localRealm.write {
                    model.isDone = true
//                }
//                self.datePredicate()
                do {
                    try self.context.save()
                } catch {
                    print(error)
                }
                self.fetchEvents()
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


