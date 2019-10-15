//
//  ViewController.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import UIKit

class CarDirectoryViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addBarButton: UIBarButtonItem!
    @IBOutlet private weak var editBarButton: UIBarButtonItem!
    
    //MARK: - Properties
    var directory = CarDirectory(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    private let cellId = "directoryCell"
    private let segueId = "addSegue"
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
        
    }
    
    private func switchEditTitle(){
        if tableView.isEditing{
            editBarButton.title = "Cancel"
            editBarButton.tintColor = UIColor.red
            addBarButton.isEnabled = false
        } else {
            editBarButton.title = "Edit"
            editBarButton.tintColor = UIColor.orange
            addBarButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            if let vc = segue.destination as? AddViewController {
                guard let data = sender as? ManagedCar else { return }
                vc.carInfo = data
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction private func editButtonTapped(_ sender: UIBarButtonItem){
        tableView.isEditing = !tableView.isEditing
        switchEditTitle()
    }
    
    @IBAction private func addButtonTapped(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: segueId, sender: nil)
    }

}

//MARK: - UITableView extension
extension CarDirectoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directory.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CarDirectoryTableViewCell
        
        let car = directory.cars[indexPath.row]
        
        
        cell.brand.text = car.brand
        cell.model.text = car.model
        cell.yearOfIssue.text = car.yearOfIssue
        cell.body.text = car.body
        
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
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueId, sender: directory.cars[indexPath.row])
    }
    
}
