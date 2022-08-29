//
//  AddEventTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit
import RealmSwift

protocol AddEventTableViewControllerDelegate {
    func addEventTableViewController(_ controller: AddEventTableViewController)
}

class AddEventTableViewController: UITableViewController  {
    
    var eventModel = EventRealmModel()
    let localRealm = try! Realm()
    
    var kindOfShooting1: KindOfShootingList?
    var amountOfHours: Int?
    var kindOfAlertOpted: KindOfAlertList?
    
    let idDatePickerCell = "idDatePickerCell"
    let idTextFieldCell = "idTextFieldCell"
    let idAddEventCell = "idAddEventCell"
    let idAddEventHeader = "idAddEventHeader"
    
    var delegate: AddEventTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Event"
        
        let cancelBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        self.navigationItem.leftBarButtonItem = cancelBarButton
        
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveBarButton
        
        updateSaveButtonState()
        
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: idDatePickerCell)
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: idTextFieldCell)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: idAddEventCell)
        tableView.register(AddEventTableViewHeader.self, forHeaderFooterViewReuseIdentifier: idAddEventHeader)
        
        tableView.keyboardDismissMode = .onDrag
        
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        RealmManager.shared.saveEventModel(model: eventModel)
        delegate?.addEventTableViewController(self)
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = eventModel.clientName != ""
        navigationItem.rightBarButtonItem!.isEnabled = shouldEnableSaveButton
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
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                if eventModel.kindOfShooting != "" {
                    cell.nameCellLabel.text = eventModel.kindOfShooting
                    cell.nameCellLabel.textColor = .label
                } else {
                    cell.nameCellLabel.text = type.description
                    cell.nameCellLabel.textColor = .systemGray2
                }
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: idDatePickerCell, for: indexPath) as! DatePickerTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                cell.nameCellLabel.text = type.description
                cell.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
                cell.datePicker.date = eventModel.dateAndTime
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                if let amountOfHours = amountOfHours {
                    cell.nameCellLabel.text = amountOfHours.description + " " + "hour(s)"
                    cell.nameCellLabel.textColor = .label
                } else {
                    cell.nameCellLabel.text = type.description
                    cell.nameCellLabel.textColor = .systemGray2
                }
                cell.accessoryType = .disclosureIndicator
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                cell.nameCellLabel.text = type.description
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellNameContactsSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            cell.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
            
            switch indexPath.row {
            case 0:
                cell.textField.tag = 0
                cell.textField.text = eventModel.clientName
                return cell
            case 1:
                cell.textField.tag = 1
                cell.textField.text = eventModel.clientPhoneNumber
                return cell
            case 2:
                cell.textField.tag = 2
                cell.textField.text = eventModel.additionalPhoneNumber
                return cell
            case 3:
                cell.textField.tag = 3
                cell.textField.text = eventModel.clientTelegramOrChat
                return cell
            case 4:
                cell.textField.tag = 4
                cell.textField.text = eventModel.clientInstagram
                return cell
            default:
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellLocationsMainSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            cell.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
            
            switch indexPath.row {
            case 0:
                cell.textField.tag = 5
                cell.textField.text = eventModel.mainLocation
                return cell
            case 1:
                cell.textField.tag = 6
                cell.textField.text = eventModel.startLocation
                return cell
            case 2:
                cell.textField.tag = 7
                cell.textField.text = eventModel.endLocation
                return cell
            default:
                return cell
            }
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellNamePaymentSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            cell.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
            
            switch indexPath.row {
            case 0:
                cell.textField.tag = 8
                cell.textField.text = eventModel.priceForHour
                return cell
            case 1:
                cell.textField.tag = 9
                cell.textField.text = eventModel.fullPrice
                return cell
            case 2:
                cell.textField.tag = 10
                cell.textField.text = eventModel.prepayment
                return cell
            default:
                return cell
            }
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
            let type = AddEventCellNameReminderSectionType.allCases[indexPath.row]
            
//            switch eventModel.alertString {
//            case "None":
//                cell.nameCellLabel.text = eventModel.alertString
//                cell.nameCellLabel.textColor = .label
//
//            default:
//                cell.nameCellLabel.text = type.description
//                cell.nameCellLabel.textColor = .darkGray
//            }
            
            
            if eventModel.alertString != "" {
                cell.nameCellLabel.text = eventModel.alertString
                cell.nameCellLabel.textColor = .label
            } else {
                cell.nameCellLabel.text = type.description
                cell.nameCellLabel.textColor = .darkGray
            }
            
            
            cell.accessoryType = .disclosureIndicator
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
            let type = AddEventCellNameContactsSectionType.allCases[indexPath.row]
            cell.nameCellLabel.text = type.description
            return cell
        }
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let date = sender.date
        try! localRealm.write {
            eventModel.dateAndTime = date
        }
    }
    
    @objc func textChanged(sender: UITextField) {
        if let name = sender.text {
            switch sender.tag {
            case 0:
                updateSaveButtonState()
                try! localRealm.write {
                    eventModel.clientName = name
                }
            case 1:
                try! localRealm.write {
                    eventModel.clientPhoneNumber = name
                }
            case 2:
                try! localRealm.write {
                    eventModel.additionalPhoneNumber = name
                }
            case 3:
                try! localRealm.write {
                    eventModel.clientTelegramOrChat = name
                }
            case 4:
                try! localRealm.write {
                    eventModel.clientInstagram = name
                }
            case 5:
                try! localRealm.write {
                    eventModel.mainLocation = name
                }
            case 6:
                try! localRealm.write {
                    eventModel.startLocation = name
                }
            case 7:
                try! localRealm.write {
                    eventModel.endLocation = name
                }
            case 8:
                try! localRealm.write {
                    eventModel.priceForHour = name
                }
            case 9:
                try! localRealm.write {
                    eventModel.fullPrice = name
                }
            case 10:
                try! localRealm.write {
                    eventModel.prepayment = name
                }
            default:
                break
            }
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
            alertVC.delegate = self
            alertVC.kindOfShooting = kindOfShooting1
            navigationController?.pushViewController(alertVC, animated: true)
        case [0, 2]:
            let alertVC = AmountOfHoursListTableViewController()
            alertVC.delegate = self
            alertVC.amountOrHours = amountOfHours
            navigationController?.pushViewController(alertVC, animated: true)
        case [4, 0]:
            let alertVC = KindOfAlertListTableViewController()
            alertVC.delegate = self
            alertVC.kindOfAlert = kindOfAlertOpted
            navigationController?.pushViewController(alertVC, animated: true)
        default:
            break
        }
    }
}

extension AddEventTableViewController: KindOfShootingTableViewControllerDelegate, AmountOfHoursListTableViewControllerDelegate, KindOfAlertListTableViewControllerDelegate {

    func kindOfShootingTableViewController(_ controller: KindOfShootingTableViewController, didSelect kindOfShooting: KindOfShootingList) {
        self.kindOfShooting1 = kindOfShooting
        updateSaveButtonState()
        try! localRealm.write {
            eventModel.kindOfShooting = kindOfShooting.description
        }
        tableView.reloadData()
    }
    
    func amountOfHoursListTableViewController(_ controller: AmountOfHoursListTableViewController, didSelect amount: Int) {
        self.amountOfHours = amount
        try! localRealm.write {
            eventModel.amountOfHours = amount
        }
        tableView.reloadData()
    }
    
    func kindOfAlertListTableViewController(_ controller: KindOfAlertListTableViewController, didSelect kindOfAlert: KindOfAlertList) {
        let currentDate = eventModel.dateAndTime
        self.kindOfAlertOpted = kindOfAlert
        try! localRealm.write {
            eventModel.alertString = kindOfAlert.description
        }
        
        switch kindOfAlert.description {
        case "None":
            try! localRealm.write {
                eventModel.alertDate = nil
            }
        case "At time of event":
            let setDate = currentDate
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "5 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -5, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "10 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -10, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "15 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -15, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "30 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -30, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "1 hour before":
            let setDate = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "2 hours before":
            let setDate = Calendar.current.date(byAdding: .hour, value: -2, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "1 day before":
            let setDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "2 days before":
            let setDate = Calendar.current.date(byAdding: .day, value: -2, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
        case "1 week before":
            let setDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)
            try! localRealm.write {
                eventModel.alertDate = setDate
            }
            print(setDate)
            
        default:
            try! localRealm.write {
                eventModel.alertDate = nil
            }
        }
        
        tableView.reloadData()
    }
}

extension AddEventTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layoutIfNeeded()
    }
}

