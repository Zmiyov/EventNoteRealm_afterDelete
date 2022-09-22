//
//  AddEventTableViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 17.08.2022.
//

import UIKit
import CoreData

protocol AddEventTableViewControllerDelegate: AnyObject {
    func addEventTableViewController(_ controller: AddEventTableViewController, event: EventEntity)
}

class AddEventTableViewController: UITableViewController  {
    
    var eventModelEntity: EventEntity?
    var eventModel = EventModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var editedDay = Date()
    
    
    var kindOfShooting1: KindOfShootingList?
    var deadlineOpted: DeadlinesList?
    var amountOfHours: Int?
    var locationData: LocationDataModel?
    var kindOfAlertOpted: KindOfAlertList?
    
    let idDatePickerCell = "idDatePickerCell"
    let idTextFieldCell = "idTextFieldCell"
    let idAddEventCell = "idAddEventCell"
    let idAddEventHeader = "idAddEventHeader"
    
    weak var delegate: AddEventTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Event"
        
//        createOrFetchEvent()
        
        copyEntityToModel()
        
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
        
        createOrFetchEvent()

        // Core Data Saving in db
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    //MARK:
        delegate?.addEventTableViewController(self, event: eventModelEntity!)
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = eventModel.clientName != nil
        navigationItem.rightBarButtonItem!.isEnabled = shouldEnableSaveButton
    }
    
    func createOrFetchEvent() {
        if eventModelEntity == nil {
            let entity = NSEntityDescription.entity(forEntityName: "EventEntity", in: context)!
            self.eventModelEntity = EventEntity(entity: entity, insertInto: context)
            copyModelToEntity()
        } else {
            copyModelToEntity()
        }
    }
    
    func copyModelToEntity() {
        eventModelEntity?.kindOfShooting = eventModel.kindOfShooting
        eventModelEntity?.dateAndTime = eventModel.dateAndTime
        eventModelEntity?.deadlineDate = eventModel.deadlineDate
        eventModelEntity?.deadlineString = eventModel.deadlineString
        eventModelEntity?.amountOfHours = Int16(eventModel.amountOfHours)
        
        eventModelEntity?.clientName = eventModel.clientName
        eventModelEntity?.clientPhoneNumber = eventModel.clientPhoneNumber
        eventModelEntity?.additionalPhoneNumber = eventModel.additionalPhoneNumber
        eventModelEntity?.clientTelegramOrChat = eventModel.clientTelegramOrChat
        eventModelEntity?.clientInstagram = eventModel.clientInstagram
        
        eventModelEntity?.mainLocation = eventModel.mainLocation
        eventModelEntity?.startLocation = eventModel.startLocation
        eventModelEntity?.endLocation = eventModel.endLocation
        
        eventModelEntity?.priceForHour = eventModel.priceForHour
        eventModelEntity?.fullPrice = eventModel.fullPrice
        eventModelEntity?.prepayment = eventModel.prepayment
        
        eventModelEntity?.alertString = eventModel.alertString
        eventModelEntity?.alertDate = eventModel.alertDate
        
        eventModelEntity?.isDone = eventModel.isDone
        eventModelEntity?.identifierID = eventModel.identifierID
    }
    
    func copyEntityToModel() {
        if let eventModelEntity = eventModelEntity  {
            eventModel.kindOfShooting = eventModelEntity.kindOfShooting
            eventModel.dateAndTime = eventModelEntity.dateAndTime
            eventModel.deadlineDate = eventModelEntity.deadlineDate
            eventModel.deadlineString = eventModelEntity.deadlineString
            eventModel.amountOfHours = Int(eventModelEntity.amountOfHours)
            
            eventModel.clientName = eventModelEntity.clientName
            eventModel.clientPhoneNumber = eventModelEntity.clientPhoneNumber
            eventModel.additionalPhoneNumber = eventModelEntity.additionalPhoneNumber
            eventModel.clientTelegramOrChat = eventModelEntity.clientTelegramOrChat
            eventModel.clientInstagram = eventModelEntity.clientInstagram
            
            eventModel.mainLocation = eventModelEntity.mainLocation
            eventModel.startLocation = eventModelEntity.startLocation
            eventModel.endLocation = eventModelEntity.endLocation
            
            eventModel.priceForHour = eventModelEntity.priceForHour
            eventModel.fullPrice = eventModelEntity.fullPrice
            eventModel.prepayment = eventModelEntity.prepayment
            
            eventModel.alertString = eventModelEntity.alertString
            eventModel.alertDate = eventModelEntity.alertDate
            
            eventModel.isDone = eventModelEntity.isDone
            eventModel.identifierID = eventModelEntity.identifierID!
        }
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
                if eventModel.kindOfShooting != nil {
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
                cell.datePicker.date = editedDay
                
                eventModel.dateAndTime = editedDay
                
                cell.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
                let type = AddEventCellNameMainSectionType.allCases[indexPath.row]

                if let deadlineString = eventModel.deadlineString {
                    cell.nameCellLabel.text = "Deadline: " + deadlineString
                    cell.nameCellLabel.textColor = .label
                } else {
                    cell.nameCellLabel.text = type.description
                    cell.nameCellLabel.textColor = .systemGray2
                }
                cell.accessoryType = .disclosureIndicator
                return cell
            case 3:
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
                cell.textField.text = eventModel.clientTelegramOrChat
                return cell
            case 3:
                cell.textField.tag = 3
                cell.textField.text = eventModel.clientInstagram
                return cell
            default:
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
            let type = AddEventCellLocationsMainSectionType.allCases[indexPath.row]
            
            if eventModel.mainLocation != nil {
                cell.nameCellLabel.text = eventModel.mainLocation
                cell.nameCellLabel.textColor = .label
            } else {
                cell.nameCellLabel.text = type.description
                cell.nameCellLabel.textColor = .systemGray2
            }
            cell.accessoryType = .disclosureIndicator
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: idTextFieldCell, for: indexPath) as! TextFieldTableViewCell
            let type = AddEventCellNamePaymentSectionType.allCases[indexPath.row]
            cell.textField.placeholder = type.description
            cell.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
            
            switch indexPath.row {
            case 0:
                cell.textField.tag = 4
                cell.textField.text = eventModel.fullPrice
                return cell
            case 1:
                cell.textField.tag = 5
                cell.textField.text = eventModel.prepayment
                return cell
            default:
                return cell
            }
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: idAddEventCell, for: indexPath) as! ListTableViewCell
            let type = AddEventCellNameReminderSectionType.allCases[indexPath.row]

            if eventModel.alertString != nil {
                cell.nameCellLabel.text = eventModel.alertString
                cell.nameCellLabel.textColor = .label
            } else {
                cell.nameCellLabel.text = type.description
                cell.nameCellLabel.textColor = .systemGray2
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
        editedDay = sender.date
        
        eventModel.dateAndTime = editedDay
        
        guard let alertString = eventModel.alertString else { return }
        eventReminderLogic(kindOfAlert: alertString)
    }
    
    @objc func textChanged(sender: UITextField) {
        if let textValue = sender.text {
            switch sender.tag {
            case 0:
                updateSaveButtonState()
                eventModel.clientName = textValue
            case 1:
                eventModel.clientPhoneNumber = textValue
            case 2:
                eventModel.clientTelegramOrChat = textValue
            case 3:
                eventModel.clientInstagram = textValue
            case 4:
                eventModel.fullPrice = textValue
            case 5:
                eventModel.prepayment = textValue
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
            let alertVC = DeadlinesListTableViewController()
            alertVC.delegate = self
            alertVC.deadline = deadlineOpted
            navigationController?.pushViewController(alertVC, animated: true)
        case [0, 3]:
            let alertVC = AmountOfHoursListTableViewController()
            alertVC.delegate = self
            alertVC.amountOrHours = amountOfHours
            navigationController?.pushViewController(alertVC, animated: true)
        case [2, 0]:
            let alertVC = MapKitViewController()
            alertVC.delegate = self
            
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

//MARK: - Delegates
extension AddEventTableViewController: KindOfShootingTableViewControllerDelegate {
    
    func kindOfShootingTableViewController(_ controller: KindOfShootingTableViewController, didSelect kindOfShooting: KindOfShootingList) {
        self.kindOfShooting1 = kindOfShooting
        updateSaveButtonState()
        
        eventModel.kindOfShooting = kindOfShooting.description
        
        tableView.reloadData()
    }
}

extension AddEventTableViewController: DeadlinesListTableViewControllerDelegate {
    func deadlinesListTableViewController(_ controller: DeadlinesListTableViewController, didSelect deadline: DeadlinesList) {
        self.deadlineOpted = deadline
        
        eventModel.deadlineString = deadline.description
        eventModel.isDone = false
        
        deadlineReminderLogic(deadline: deadline.description)
        tableView.reloadData()
    }
    
    fileprivate func deadlineReminderLogic(deadline: String) {
        
        guard let currentDate = eventModel.dateAndTime else { return }
        
        switch deadline {
        case "None":
            eventModel.deadlineDate = nil
        case "In a day":
            let setDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a week":
            let setDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a two weeks":
            let setDate = Calendar.current.date(byAdding: .day, value: 14, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a month":
            let setDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a two months":
            let setDate = Calendar.current.date(byAdding: .month, value: 2, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a three months":
            let setDate = Calendar.current.date(byAdding: .month, value: 3, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a four months":
            let setDate = Calendar.current.date(byAdding: .month, value: 4, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a five months":
            let setDate = Calendar.current.date(byAdding: .month, value: 5, to: currentDate)
            eventModel.deadlineDate = setDate
        case "In a six months":
            let setDate = Calendar.current.date(byAdding: .month, value: 6, to: currentDate)
            eventModel.deadlineDate = setDate
        default:
            eventModel.deadlineDate = nil
        }
    }
}

extension AddEventTableViewController: AmountOfHoursListTableViewControllerDelegate {
    func amountOfHoursListTableViewController(_ controller: AmountOfHoursListTableViewController, didSelect amount: Int) {
        self.amountOfHours = amount

        eventModel.amountOfHours = amount

        tableView.reloadData()
    }
}

extension AddEventTableViewController: MapKitViewControllerDelegate {
    func mapKitViewController(_ controller: MapKitViewController, didSelect locationData: LocationDataModel) {
        self.locationData = locationData
        eventModel.mainLocation = locationData.name
    }
}


extension AddEventTableViewController: KindOfAlertListTableViewControllerDelegate {
    func kindOfAlertListTableViewController(_ controller: KindOfAlertListTableViewController, didSelect kindOfAlert: KindOfAlertList) {
        self.kindOfAlertOpted = kindOfAlert
        
        eventModel.alertString = kindOfAlert.description
        
        eventReminderLogic(kindOfAlert: kindOfAlert.description)
        tableView.reloadData()
    }
    
    fileprivate func eventReminderLogic(kindOfAlert: String) {
        
        guard let currentDate = eventModel.dateAndTime else { return }
        
        switch kindOfAlert {
        case "None":
            eventModel.alertDate = nil
        case "At time of event":
            let setDate = currentDate
            eventModel.alertDate = setDate
        case "5 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -5, to: currentDate)
            eventModel.alertDate = setDate
        case "10 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -10, to: currentDate)
            eventModel.alertDate = setDate
        case "15 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -15, to: currentDate)
            eventModel.alertDate = setDate
        case "30 minutes before":
            let setDate = Calendar.current.date(byAdding: .minute, value: -30, to: currentDate)
            eventModel.alertDate = setDate
        case "1 hour before":
            let setDate = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate)
            eventModel.alertDate = setDate
        case "2 hours before":
            let setDate = Calendar.current.date(byAdding: .hour, value: -2, to: currentDate)
            eventModel.alertDate = setDate
        case "1 day before":
            let setDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
            eventModel.alertDate = setDate
        case "2 days before":
            let setDate = Calendar.current.date(byAdding: .day, value: -2, to: currentDate)
            eventModel.alertDate = setDate
        case "1 week before":
            let setDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)
            eventModel.alertDate = setDate
        default:
            eventModel.alertDate = nil
        }
    }
}

extension AddEventTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layoutIfNeeded()
    }
}
