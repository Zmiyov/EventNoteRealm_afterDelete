//
//  AddEventTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit

class AddEventTableViewController: UITableViewController  {
    
    var event: Event?
    
//    var kindOfAlertOpted: String?
//    var kindOfShooting: String?
    
    let idTextFieldCell = "idTextFieldCell"
    let idAddEventCell = "idAddEventCell"
    let idAddEventHeader = "idAddEventHeader"
    
    var addEventCellName: AddEventCellNameMainSectionType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: idTextFieldCell)
        tableView.register(AddEventTableViewCell.self, forCellReuseIdentifier: idAddEventCell)
        tableView.register(AddEventTableViewHeader.self, forHeaderFooterViewReuseIdentifier: idAddEventHeader)
        
        title = "New Event"
    }
    
    
    //MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return AddEventCellNameMainSectionType.allCases.count
        case 1: return AddEventCellNameContactsSectionType.allCases.count
        case 2: return AddEventCellLocationsMainSectionType.allCases.count
        case 3: return AddEventCellNamePaymentSectionType.allCases.count
        case 4: return AddEventCellNameReminderSectionType.allCases.count
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                var content = cell.defaultContentConfiguration()
                content.text = type.description
                cell.contentConfiguration = content
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                var content = cell.defaultContentConfiguration()
                content.text = type.description
                cell.contentConfiguration = content
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                var content = cell.defaultContentConfiguration()
                content.text = type.description
                cell.contentConfiguration = content
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                var content = cell.defaultContentConfiguration()
                content.text = type.description
                cell.contentConfiguration = content
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                var content = cell.defaultContentConfiguration()
                content.text = type.description
                cell.contentConfiguration = content
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellNameContactsSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellLocationsMainSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellNamePaymentSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
            let type = AddEventCellNameReminderSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
            let type = AddEventCellNameContactsSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAddEventHeader ) as! AddEventTableViewHeader
        header.headerConfigure(section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            let alertVC = KindOfShootingTableViewController()
            alertVC.modalTransitionStyle = .coverVertical
            let navController = UINavigationController(rootViewController: alertVC)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = appearance
            present(navController, animated: true)
        case [0, 3]:
            let alertVC = AmountOfHoursListTableViewController()
            alertVC.modalTransitionStyle = .coverVertical
            let navController = UINavigationController(rootViewController: alertVC)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = appearance
            present(navController, animated: true)
        case [4, 0]:
            let alertVC = KindOfAlertListTableViewController()
            alertVC.modalTransitionStyle = .coverVertical
            let navController = UINavigationController(rootViewController: alertVC)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = appearance
            present(navController, animated: true)
        default:
            break
        }
    }
}

//extension AddEventTableViewController: KindOfShootingTableViewControllerDelegate, AmountOfHoursListTableViewControllerDelegate, KindOfAlertListTableViewControllerDelegate {
//    func kindOfAlertListTableViewController(_ controller: KindOfAlertListTableViewController, didSelect kindOfAlert: KindOfAlertList) {
//        kindOfAlertOpted = kindOfAlert.description
//    }
//
//    func amountOfHoursListTableViewController(_ controller: AmountOfHoursListTableViewController, didSelect amount: Int) {
//        event?.amountOfHours = amount
//    }
//
//    func kindOfShootingTableViewController(_ controller: KindOfShootingTableViewController, didSelect kindOfShooting: KindOfShootingList) {
//        event?.kindOfShooting = kindOfShooting.description
//    }
//}


