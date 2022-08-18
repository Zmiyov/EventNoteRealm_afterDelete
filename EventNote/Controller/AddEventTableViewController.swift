//
//  AddEventTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit

class AddEventTableViewController: UITableViewController  {
    
    var event: Event?
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
        
        switch indexPath.section {
        case 0:
            let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        case 1:
            let type = AddEventCellNameContactsSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        case 2:
            let type = AddEventCellLocationsMainSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        case 3:
            let type = AddEventCellNamePaymentSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        case 4:
            let type = AddEventCellNameReminderSectionType.allCases[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            return cell
        default:
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
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                navigationController?.pushViewController(alertVC, animated: true)
        case [0, 3]:
                let alertVC = AmountOfHoursListTableViewController()
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                navigationController?.pushViewController(alertVC, animated: true)
        case [4, 0]:
                let alertVC = KindOfAlertListTableViewController()
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                navigationController?.pushViewController(alertVC, animated: true)
        default:
            break
        }
    }
}
