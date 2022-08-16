//
//  AddEventViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit

class AddEventViewController: UITableViewController  {
    
    let idAddEventCell = "idAddEventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idAddEventCell)
        
        title = "New Event"
        view.backgroundColor = .red
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 2
        case 3: return 2
        case 4: return 2
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath)
        cell.textLabel?.text = "Cell"
        return cell
    }
    
}
