//
//  KindOfShootingTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 18.08.2022.
//

import UIKit

protocol KindOfShootingTableViewControllerDelegate {
    func kindOfShootingTableViewController(_ controller: KindOfShootingTableViewController, didSelect kindOfShooting: KindOfShootingList)
}

class KindOfShootingTableViewController: UITableViewController {
    
    let idKindOfShootingCell = "idKindOfShootingCell"
    let idKindOfShootingCellHeader = "idKindOfShootingCellHeader"
    
    var delegate: KindOfShootingTableViewControllerDelegate?
    var kindOfShooting: KindOfShootingList?
    
    let kindOfShootingTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kind Of Shooting".localized()
        
        self.tableView = kindOfShootingTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idKindOfShootingCell)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: idKindOfShootingCellHeader)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KindOfShootingList.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idKindOfShootingCell, for: indexPath)
        
        let type = KindOfShootingList.allCases[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = type.description.localized()
        cell.contentConfiguration = content
        
        if kindOfShooting == type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        kindOfShooting = KindOfShootingList.allCases[indexPath.row]
        if let kindSelected = kindOfShooting {
            delegate?.kindOfShootingTableViewController(self, didSelect: kindSelected)
            tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idKindOfShootingCellHeader)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 40
        default: return 15
        }
    }
}
