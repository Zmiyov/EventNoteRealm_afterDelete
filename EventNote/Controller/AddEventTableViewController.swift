//
//  AddEventTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit
import RealmSwift

class AddEventTableViewController: UITableViewController  {
    
    let eventModel = EventRealmModel()
    
    var kindOfShooting1: KindOfShootingList?
    var amountOfHours: Int?
    var kindOfAlertOpted: KindOfAlertList?
    
    let idDatePickerCell = "idDatePickerCell"
    let idTextFieldCell = "idTextFieldCell"
    let idAddEventCell = "idAddEventCell"
    let idAddEventHeader = "idAddEventHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Event"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
    
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
//        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: idDatePickerCell)
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: idTextFieldCell)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: idAddEventCell)
        tableView.register(AddEventTableViewHeader.self, forHeaderFooterViewReuseIdentifier: idAddEventHeader)
        
        
        
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        RealmManager.shared.saveEventModel(model: eventModel)
        dismiss(animated: true, completion: nil)
    }
    
//    private func updateSaveButtonState() {
//        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false && kindOfShooting1 != nil
//        saveBarButtonItem.isEnabled = shouldEnableSaveButton
//    }
    
    
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
                if let kindOfShooting1 = kindOfShooting1 {
                    cell.nameCellLabel.text = kindOfShooting1.description
                    cell.nameCellLabel.textColor = .label
                    eventModel.kindOfShooting = kindOfShooting1.description
                } else {
                    cell.nameCellLabel.text = type.description
                    cell.nameCellLabel.textColor = .darkGray
                }
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: idDatePickerCell, for: indexPath) as! DatePickerTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                cell.nameCellLabel.text = type.description
                eventModel.dateAndTime = cell.datePicker.date
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]
                if let amountOfHours = amountOfHours {
                    cell.nameCellLabel.text = amountOfHours.description + " " + "hour(s)"
                    cell.nameCellLabel.textColor = .label
                    eventModel.amountOfHours = amountOfHours
                } else {
                    cell.nameCellLabel.text = type.description
                    cell.nameCellLabel.textColor = .darkGray
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
            if let kindOfAlertOpted = kindOfAlertOpted {
                cell.nameCellLabel.text = kindOfAlertOpted.description
                cell.nameCellLabel.textColor = .label
                eventModel.alertString = kindOfAlertOpted.description
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
    
    @objc func textChanged(sender: UITextField) {
        if let name = sender.text {
            switch sender.tag {
            case 0:
                eventModel.clientName = name
            case 1:
                eventModel.clientPhoneNumber = name
            case 2:
                eventModel.additionalPhoneNumber = name
            case 3:
                eventModel.clientTelegramOrChat = name
            case 4:
                eventModel.clientInstagram = name
            case 5:
                eventModel.mainLocation = name
            case 6:
                eventModel.startLocation = name
            case 7:
                eventModel.endLocation = name
            case 8:
                eventModel.priceForHour = name
            case 9:
                eventModel.fullPrice = name
            case 10:
                eventModel.prepayment = name
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
    func kindOfAlertListTableViewController(_ controller: KindOfAlertListTableViewController, didSelect kindOfAlert: KindOfAlertList) {
        self.kindOfAlertOpted = kindOfAlert
        tableView.reloadData()
    }

    func amountOfHoursListTableViewController(_ controller: AmountOfHoursListTableViewController, didSelect amount: Int) {
        self.amountOfHours = amount
        tableView.reloadData()
    }

    func kindOfShootingTableViewController(_ controller: KindOfShootingTableViewController, didSelect kindOfShooting: KindOfShootingList) {
        self.kindOfShooting1 = kindOfShooting
        tableView.reloadData()
    }
}

extension AddEventTableViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layoutIfNeeded()
    }
}

