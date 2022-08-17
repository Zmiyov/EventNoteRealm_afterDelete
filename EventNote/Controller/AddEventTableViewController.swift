//
//  AddEventTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit

class AddEventTableViewController: UITableViewController  {
    
    let idAddEventCell = "idAddEventCell"
    let idAddEventHeader = "idAddEventHeader"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.register(AddEventTableViewCell.self, forCellReuseIdentifier: idAddEventCell)
        tableView.register(AddEventTableViewHeader.self, forHeaderFooterViewReuseIdentifier: idAddEventHeader)
        
        title = "New Event"

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 4
        case 2: return 3
        case 3: return 3
        case 4: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! AddEventTableViewCell
        cell.cellConfigure(indexPath: indexPath )
        return cell
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

        if indexPath == [4, 0] {
            
            let alertVC = KindOfAlertListTableViewController()
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            navigationController?.pushViewController(alertVC, animated: true)
        }
    }
}
