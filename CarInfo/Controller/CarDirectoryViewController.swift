//
//  ViewController.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import UIKit

class CarDirectoryViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var editBarButton: UIBarButtonItem!
    
    //MARK: Properties
    var directory = CarDirectory([])
    
    private let cellId = "Cell"
    private let segueId = "addSegue"
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func configure(){
        directory.add(newCar: Car(yearOfIssue: 192, manufacturer: "assa", model: "sasda", body: .Coupe), at: 0)
        directory.add(newCar: Car(yearOfIssue: 193, manufacturer: "assa", model: "sasda", body: .Coupe), at: 0)
        directory.add(newCar: Car(yearOfIssue: 194, manufacturer: "assa", model: "sasda", body: .Coupe), at: 0)
        directory.add(newCar: Car(yearOfIssue: 195, manufacturer: "assa", model: "sasda", body: .Coupe), at: 0)
    }
    
    private func switchEditTitle(){
        if tableView.isEditing{
            editBarButton.title = "Cancel"
        } else {
            editBarButton.title = "Edit"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            if let vc = segue.destination as? EditDirectoryViewController {
                guard let data = sender as? Car else { return }
                vc.carInfo = data
            }
        }
    }
    
    //MARK: IBActions
    @IBAction private func editButtonTapped(_ sender: UIBarButtonItem){
        tableView.isEditing = !tableView.isEditing
        switchEditTitle()
    }
    
    @IBAction private func addButtonTapped(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: segueId, sender: nil)
    }

}

//MARK: Extensions
extension CarDirectoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directory.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CarDirectoryTableViewCell
        
        let car = directory.cars[indexPath.row]
        
        cell.manufacturer.text = car.manufacturer
        cell.model.text = car.model
        cell.yearOfIssue.text = String(car.yearOfIssue)
        cell.type.text = String(describing: car.body)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            directory.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = directory.cars[sourceIndexPath.row]
        directory.remove(at: sourceIndexPath.row)
        directory.add(newCar: item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueId, sender: directory.cars[indexPath.row])
    }
    
}
