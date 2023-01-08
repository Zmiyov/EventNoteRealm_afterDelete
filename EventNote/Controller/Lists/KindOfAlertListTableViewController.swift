//
//  KindOfAlertListTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit

protocol KindOfAlertListTableViewControllerDelegate {
    func kindOfAlertListTableViewController(_ controller: KindOfAlertListTableViewController, didSelect kindOfAlert: KindOfAlertList)
}

class KindOfAlertListTableViewController: UITableViewController {
    
    let idKindOfAlertCell = "idKindOfAlertCell"
    let idKindOfAlertCellHeader = "idKindOfAlertCellHeader"
    
    var delegate: KindOfAlertListTableViewControllerDelegate?
    var kindOfAlert: KindOfAlertList?

    let alertsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Alert".localized()
        
        self.tableView = alertsTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idKindOfAlertCell)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: idKindOfAlertCellHeader)

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 10
        default: return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idKindOfAlertCell", for: indexPath)
        switch indexPath {
        case [0, 0]:
            let type = KindOfAlertList.allCases[indexPath.row]
            
            var content = cell.defaultContentConfiguration()
            content.text = type.description.localized()
            cell.contentConfiguration = content
            
            if kindOfAlert == type {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        default:
            let type = KindOfAlertList.allCases[indexPath.row + 1]
            
            var content = cell.defaultContentConfiguration()
            content.text = type.description.localized()
            cell.contentConfiguration = content
            
            if kindOfAlert == type {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            kindOfAlert = KindOfAlertList.allCases[indexPath.row]
            if let kindSelected = kindOfAlert {
                delegate?.kindOfAlertListTableViewController(self, didSelect: kindSelected)
                tableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        default:
            kindOfAlert = KindOfAlertList.allCases[indexPath.row + 1]
            if let kindSelected = kindOfAlert {
                delegate?.kindOfAlertListTableViewController(self, didSelect: kindSelected)
                tableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idKindOfAlertCellHeader)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 40
        default: return 15
        }
    }
}
