//
//  EditDirectoryViewController.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import UIKit

class EditDirectoryViewController: UIViewController {
    
    //MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var carInfo: Car? = nil
    private let numberOfRows = 4
    
    private let cellIdForString = "cellForString"
    private let cellIdForPicker = "cellForPicker"

    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    //MARK: IBActions

}

//MARK: Extensions
extension EditDirectoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0, 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForString, for: indexPath) as? ForStringTableViewCell else { return UITableViewCell() }
            
            if indexPath.row == 1 {
                if let car = carInfo {
                    cell.textField.text = car.model
                }else{
                    cell.textField.placeholder = "Model"
                }
            } else {
                if let car = carInfo {
                    cell.textField.text = car.manufacturer
                }else{
                    cell.textField.placeholder = "Manufacturer"
                }
            }
            
            return cell
        case 2, 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForPicker, for: indexPath) as? ForPickerTableViewCell {
                if indexPath.row == 2 {
                    cell.title.text = "Body"
                    if let car = carInfo {
                        cell.info.text = String(describing: car.body)
                    }
                } else {
                    cell.title.text = "Year"
                    if let car = carInfo {
                        cell.info.text = String(car.yearOfIssue)
                    }
                }
                return cell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ForPickerTableViewCell {
            cell.bodyTypePicker.isHidden = !cell.bodyTypePicker.isHidden
        }
    }
    
    
}
