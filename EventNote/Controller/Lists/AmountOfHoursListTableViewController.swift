//
//  AmountOfHoursListTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 18.08.2022.
//

import UIKit

protocol AmountOfHoursListTableViewControllerDelegate {
    func amountOfHoursListTableViewController(_ controller: AmountOfHoursListTableViewController, didSelect amount: Int)
}

class AmountOfHoursListTableViewController: UITableViewController {
    
    let idAmountOfHoursListCell = "idAmountOfHoursListCell"
    let idAmountOfHoursListCellHeader = "idAmountOfHoursListCellHeader"

    var amountOrHours: Int?
    var delegate: AmountOfHoursListTableViewControllerDelegate?
    
    let alertsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Amount Of Hour"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        
        self.tableView = alertsTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idAmountOfHoursListCell)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: idAmountOfHoursListCellHeader)
    }
<<<<<<< HEAD
=======
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
>>>>>>> parent of 01cb934 (Polish segue present)

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 12
        default: return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAmountOfHoursListCell, for: indexPath)
        for i in 1...indexPath.row + 1 {
            var content = cell.defaultContentConfiguration()
            content.text = String(i)
            cell.contentConfiguration = content
        }
//TODO: switch for none
        if amountOrHours != nil && amountOrHours == indexPath.row + 1 {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        amountOrHours = indexPath.row + 1
        if let kindSelected = amountOrHours {
            delegate?.amountOfHoursListTableViewController(self, didSelect: kindSelected)
            tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAmountOfHoursListCellHeader)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 40
        default: return 15
        }
    }
}
